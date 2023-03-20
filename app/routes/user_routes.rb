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

          status 201
          json serializer.serializable_hash
        else
          status 422
          error_response result.errors || result.user
        end
      end

      get 'sleep_periods' do
      end

      get 'friends' do
      end
    end
  end
end
