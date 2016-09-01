# coding: utf-8
module Api
  module V1
    class TipsController < ApplicationController
      # 動作確認用にCSRFを無効化しています
      skip_before_action :verify_authenticity_token

      def index
        render json: Tip.all
      end

      api!
      def recommend
        tips = []
        Tip.where( :available => 1 ).limit(5).desc(:clicks).each do |tip|
          tip.thumb = "http://#{request.host_with_port}/thumb/#{tip.name}.png"
          tip.route = "http://#{request.host_with_port}/documents/#{tip.route}"
          tips << tip
        end
        render json: tips
      end

      api!
      def regions
        regions = YAML.load(File.open(Rails.root.join("public/tips.yml")))

        render json: regions
      end
    end
  end
end
