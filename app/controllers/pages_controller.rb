class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def get_inspired
    @posts = Post.all.shuffle.take(10)
    @qr_codes = []
    @posts.each do |post|
      qr = RQRCode::QRCode.new(url_for(post_path(post)))
      svg = qr.as_svg(
        color: "000",
        shape_rendering: "crispEdges",
        module_size: 11,
        standalone: true,
        use_path: true
      )
      @qr_codes << svg
    end
  end
end
