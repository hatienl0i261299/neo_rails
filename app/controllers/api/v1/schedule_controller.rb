# frozen_string_literal: true

require_relative '../../../../common/helper'

module Api
  module V1
    class ScheduleController < ApplicationController
      def index
        schedule = Schedule.all.order(id: :asc).paging(params[:page], params[:per_page])
        render json: {
          **pagination(schedule),
          data: schedule.map { |item| ScheduleSerializer.new(item).serializable_hash }
        }, adapter: nil, status: :ok
      end

      def update
        schedule_id = params[:id]
        time_start = params[:time_start]
        time_end = params[:time_end]

        schedule = Schedule.find(schedule_id)

        schedule.time_start = time_start || schedule.time_start
        schedule.time_end = time_end || schedule.time_end
        schedule.save!
        head :no_content
      end

      def show
        schedule_id = params[:id]
        nurse_schedule = NurseSchedule.where(schedule_id: schedule_id).paging(params[:page], params[:per_page])
        render json: {
          **pagination(nurse_schedule),
          data: nurse_schedule.map { |item| NurseScheduleSerializer.new(item).serializable_hash }
        }, adapter: nil, status: :ok
      end

      def create
        schedule = Schedule.new time_start: params[:time_start], time_end: params[:time_end]
        schedule.save!
        render json: schedule, status: :ok
      end

      def destroy
        schedule = Schedule.find(params[:id])
        schedule.destroy!
        head :no_content
      end
    end
  end
end
