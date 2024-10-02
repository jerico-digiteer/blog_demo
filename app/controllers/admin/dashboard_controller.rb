class Admin::DashboardController < ApplicationController
    before_action :authenticate_admin!
    
    def index
      # Admin-specific logic
    end
  end
  