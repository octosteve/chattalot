defmodule Chattalot.BotSupervisor do
  use Supervisor
  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def make_bot(bot_name) do
    Supervisor.start_child(__MODULE__, [%{name: bot_name}])
  end

  def init([]) do
    children = [
      worker(Chattalot.Bot, [],[restart: :permanent])
    ]
    supervise(children, strategy: :simple_one_for_one)
  end
end
