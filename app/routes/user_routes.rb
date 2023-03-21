class UserRoutes < Application
  helpers PaginationLinks

  namespace '/v1/users' do
    post 'follow' do
    end

    namespace '/:user_id' do
      get do
        result = Users::FindService.call(id: params[:user_id])

        if result.success?
          serializer = UserSerializer.new(result.user)

          status 200
          json serializer.serializable_hash
        else
          status 422
          error_response result.errors || result.user
        end
      end

      get '/sleep_periods' do
        page = params[:page].presence || 1
        result = Users::FindService.call(id: params[:user_id])

        if result.success?
          sleep_periods = result.user.sleep_periods_dataset.completed.ordered
          sleep_periods = sleep_periods.paginate(page.to_i, Settings.pagination.page_size)
          serializer = SleepPeriodSerializer.new(sleep_periods.all, links: pagination_links(sleep_periods))

          status 200
          json serializer.serializable_hash
        else
          status 422
          error_response result.errors || result.user
        end
      end

      get 'friends' do
      end
    end
  end
end
