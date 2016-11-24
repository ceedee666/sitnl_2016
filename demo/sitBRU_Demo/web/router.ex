defmodule SitBRU_Demo.Router do
  use SitBRU_Demo.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SitBRU_Demo do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/sitbru2016", SitController, :index
  end

  

  # Other scopes may use custom stacks.
  # scope "/api", SitBRU_Demo do
  #   pipe_through :api
  # end
end
