# frozen_string_literal: true

require_relative '../../../../common/helper'

module Api
  module V1
    class NurseController < ApplicationController
      def index
        nurse = Nurse
                .paging(params[:page], params[:per_page])
                .preload(:nurse_schedules, :schedules).order(updated_at: :desc)
        render json: {
          **pagination(nurse),
          data: nurse.map { |item| NurseSerializer.new(item).serializable_hash }
        }, status: :ok
      end

      def show
        nurse = Nurse.includes(:schedules).find(params[:id])
        render json: nurse, status: :ok
      end

      def update
        nurse = Nurse.find(params[:nurse_id])
        num = add(1, 2)
        p num
        nurse.name = params[:name]
        nurse.phone = params[:phone]
        nurse.address = params[:address]
        nurse.save!
        render json: :ok, status: :no_content
      end

      def destroy
        nurse = Nurse.find(params[:id])
        nurse.destroy!
        head :no_content
      end

      def create
        nurse = Nurse.new(name: params[:name], phone: params[:phone], address: params[:address])
        nurse.save!
        Schedule.all.map do |schedule|
          NurseSchedule.create do |nurse_schedule|
            nurse_schedule.nurse = nurse
            nurse_schedule.schedule = schedule
          end
        end

        render json: nurse, status: :created
      end

      def update_nurse_booked
        data = params[:_json]
        NurseSchedule.transaction do
          data.map do |item|
            nurse_schedule = NurseSchedule.find(item[:id])
            booked = str_to_boolean(item[:booked])
            if [true, false].include? booked
              nurse_schedule.booked = item[:booked]
              nurse_schedule.nurse.updated_at = Time.current
              nurse_schedule.nurse.save!
              nurse_schedule.save!
            else
              return bad_request "'#{item[:booked]}' is not a valid type"
            end
          end
        end
        head :no_content
      end

      def add_schedules
        data = params[:_json]
        nurse_id = params[:nurse_id]

        NurseSchedule.create!(
          data.map do |item|
            {
              booked: false,
              schedule_id: item['id'],
              nurse_id: nurse_id
            }
          end
        )

        head :created
      end
    end
  end
end
