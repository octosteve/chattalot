defmodule Chattalot do
  use Application
  def start(_, _) do
    Chattalot.BotSupervisor.start_link
    Chattalot.BotSupervisor.make_bot("Nunez")
  end
end
