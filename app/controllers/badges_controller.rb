class BadgesController < ApplicationController
  before_action :set_badge, only: [:show]

  # GET /badges
  def index
    @badges = Badge.all.map(&:new).sort_by(&:display_name)
    @badges_allocated_counts = UserBadge.group(:badge_id).count
  end

  # GET /badges/49er
  def show
    @recipients = User.joins(:user_badges).where("user_badges.badge_id" => @badge.class.id)
    @recipients.order!("users.name")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_badge
      @badge = Badge.find_by_slug(params[:slug]).new
    end
end
