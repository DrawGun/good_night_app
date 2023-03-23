require 'sinatra/custom_logger'

class Application < Sinatra::Base
  helpers Sinatra::CustomLogger
  helpers Validations
  helpers PaginationLinks

  configure do
    register Sinatra::Namespace
    register ApiErrors

    set :app_file, File.expand_path('../config.ru', __dir__)
  end

  configure :development do
    register Sinatra::Reloader

    set :show_exceptions, false
  end

  namespace '/v1' do
    namespace '/sleep_periods' do
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

      namespace '/:sleep_period_id/wake_up' do
        put do
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

    namespace '/users/:user_id' do
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

      post '/follow' do
        follow_params = validate_with!(Followings::FollowParamsContract)

        result = Followings::FollowService.call(
          follower_id: follow_params[:user_id],
          followee_id: follow_params[:followings][:followee_id]
        )

        if result.success?
          serializer = FollowingSerializer.new(result.following.reload)

          status 201
          json serializer.serializable_hash
        else
          status 422
          error_response result.errors || result.following
        end
      end

      delete '/unfollow' do
        unfollow_params = validate_with!(Followings::UnfollowParamsContract)

        result = Followings::UnfollowService.call(
          follower_id: unfollow_params[:user_id],
          followee_id: unfollow_params[:followings][:followee_id]
        )

        if result.success?
          status 204
        else
          status 422
          error_response result.errors
        end
      end

      get '/friends' do
        page = params[:page].presence || 1
        result = Users::FriendsSleepPeriodService.call(id: params[:user_id])

        if result.success?
          sleep_periods = Followings::SleepPeriodsQuery.new(user: result.user).call
          sleep_periods = sleep_periods.paginate(page.to_i, Settings.pagination.page_size)
          serializer = SleepPeriodSerializer.new(sleep_periods.all, links: pagination_links(sleep_periods))

          status 200
          json serializer.serializable_hash
        else
          status 422
          error_response result.errors
        end
      end
    end
  end
end
