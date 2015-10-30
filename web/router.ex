defmodule Nielson.Router do
  use Nielson.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Nielson.Plugs.SetCurrentUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticated do
    plug Nielson.Plugs.AuthenticateUser
  end

  scope "/", Nielson do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/posts", PostController, only: [:show]

    get "/login", SessionController, :new
    post "/login", SessionController, :create
    delete "/logout", SessionController, :delete

    scope "/admin", as: :admin do
      pipe_through :authenticated
      resources "/posts", Admin.PostController, except: [:show]
    end
  end



  # Other scopes may use custom stacks.
  # scope "/api", Nielson do
  #   pipe_through :api
  # end
end
