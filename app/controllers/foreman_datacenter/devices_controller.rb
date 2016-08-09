module ForemanDatacenter
  class DevicesController < ApplicationController
    before_action :set_device, only: [:show, :edit, :update, :destroy]

    def index
      @devices = Device.includes(:device_role, :device_type, rack: [:site]).all
    end

    def show
    end

    def new
      @device = Device.new
    end

    def edit
    end

    def create
      @device = Device.new(device_params)

      if @device.save
        process_success object: @device
      else
        process_error object: @device
      end
    end

    def update
      if @device.update(device_params)
        process_success object: @device
      else
        process_error object: @device
      end
    end

    def destroy
      if @device.destroy
        process_success object: @device
      else
        process_error object: @device
      end
    end

    def device_types
      @manufacturer_id = params[:manufacturer_id]
      render partial: 'device_types'
    end

    def racks
      @site_id = params[:site_id]
      render partial: 'racks'
    end

    private

    def set_device
      @device = Device.find(params[:id])
    end

    def device_params
      params[:device].permit(:device_type_id, :device_role_id, :platform_id,
                             :name, :serial, :rack_id, :position, :face,
                             :status, :primary_ip4, :primary_ip6, :comments)
    end
  end
end