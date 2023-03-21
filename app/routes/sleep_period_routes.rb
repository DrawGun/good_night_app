class SleepPeriodRoutes < Application
  namespace '/v1/sleep_periods' do
    post do
      sleep_period_params = validate_with!(SleepPeriods::CreateParamsContract)

      result = SleepPeriods::CreateService.call(sleep_period_params: sleep_period_params[:sleep_period])

      if result.success?
        serializer = SleepPeriodSerializer.new(result.sleep_period.reload)

        status 201
        json serializer.serializable_hash
      else
        status 422
        error_response result.errors || result.sleep_period
      end
    end

    put '/:sleep_period_id/wake_up' do
      sleep_period_params = validate_with!(SleepPeriods::WakeUpParamsContract)

      result = SleepPeriods::WakeUpService.call(
        id: sleep_period_params[:sleep_period_id],
        data: sleep_period_params[:sleep_period]
      )

      if result.success?
        serializer = SleepPeriodSerializer.new(result.sleep_period.reload)

        status 200
        json serializer.serializable_hash
      else
        status 422
        error_response result.errors || result.sleep_period
      end
    end
  end
end
