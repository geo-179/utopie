class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def get_inspired
    @posts = Post.all.shuffle.take(10)
  end
end
