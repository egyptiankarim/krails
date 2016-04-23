class StaticController < ApplicationController
  layout :resolve_layout

  def index
    # Hi!
  end

  def about
  end

  def resolve_layout
    case action_name
    when 'index'
      'jumbotron'
    else
      'application'
    end
  end
end
