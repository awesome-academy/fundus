class EventsController < ApplicationController
  before_action :authenticate_user!, except: %i{show edit}
  before_action :correct_user, only: %i{destroy}
  before_action  :get_event, :get_attendance, only: %i{show}
  before_action :get_category, only: %i(index show)

  def new
    @event = current_user.events.build
  end

  def index
    @search = Event.search(params[:q])
    @events = @search.result.sort_by_created.paginate page: params[:page], per_page: 6
  end

  def show
  end

  def create
    @event = current_user.events.build event_params
    if @event.save
      redirect_to event_path  @event
    else
      flash[:danger] = @event.errors
      render :new
    end
  end

  def destroy
    if @event.destroy
      redirect_to user_path id: @event.user_id
    else
      redirect_to user_path id: @event.user_id
    end
  end

  private
  def event_params
    params.require(:event).permit :title, :category_id, :place, :start_time, :end_time, :content, :expiration_date
  end

  def correct_user
    @event = current_user.events.find_by id: params[:id]
    redirect_to root_path if @event.nil?
  end

  def get_attendance
    @attendance = @event.active_attendances.find_by user_id: current_user.id if user_signed_in?
  end

  def get_event
    @event = Event.find_by id: params[:id]
    return if @event
    redirect_to root_path
  end

  def get_category
    @categories = Category.all
  end
end
