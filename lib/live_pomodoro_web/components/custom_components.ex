defmodule LivePomodoroWeb.CustomComponents do
  @moduledoc false
  use Phoenix.Component

  alias LivePomodoroWeb.CoreComponents
  alias Phoenix.LiveView.JS

  @doc """
  Renders a button to toggle the application theme
  """
  attr :theme, :string, required: true

  def toggle_theme_button(assigns) do
    ~H"""
    <div
      class="flex items-center gap-4 font-semibold leading-6"
      phx-hook="Theme"
      id="theme-hook"
    >
      <a
        class="hover:text-zinc-700 cursor-pointer h-5 w-5 leading-3"
        href="#"
        phx-key=";"
        phx-window-keydown={JS.dispatch("toggle-theme")}
        phx-click={JS.dispatch("toggle-theme")}
        tabindex="0"
      >
        <%= if @theme === "dark" do %>
          <CoreComponents.icon
            id="toggle-theme-icon"
            name="hero-sun-solid"
            class="text-black dark:text-white h-5 w-5 hover:text-yellow-500 hover:dark:text-yellow-500 transition-colors duration-500"
          />
        <% else %>
          <CoreComponents.icon
            id="toggle-theme-icon"
            name="hero-moon-solid"
            class="text-black dark:text-white h-5 w-5 hover:text-yellow-500 hover:dark:text-yellow-500 transition-colors duration-500"
          />
        <% end %>
      </a>
    </div>
    """
  end

  attr :id, :string, default: "presence-disclaimer"
  attr :disclaimer_content, :string, required: true

  def presence_disclaimer(assigns) do
    ~H"""
    <.live_component
      id={@id}
      module={LivePomodoroWeb.CustomComponents.PresenceDisclaimer}
      disclaimer_content={@disclaimer_content}
    />
    """
  end
end
