defmodule Chattalot.Bot do
  use Slack
  require IEx

  def start_link(state) do
    Chattalot.Bot.start_link(System.get_env("SLACK_TOKEN") , state)
  end

  def handle_message(%{type: "message", text: "remember to say:" <> thing_to_remember} = message, slack, state) do
    send_message("#{state.name}: Remembering to say: #{thing_to_remember}", message.channel, slack)
    messages = Map.get(state, :messages, [])
    state = Map.put(state, :messages, [thing_to_remember | messages])
    {:ok, state}
  end

  def handle_message(%{type: "message", text: "make " <> bot_name} = message, slack, state) do
    send_message("#{state.name}: Making #{bot_name}", message.channel, slack)
    Chattalot.BotSupervisor.make_bot(bot_name)
    {:ok, state}
  end

  def handle_message(%{type: "message", text: "say something random " <> bot_name} = message, slack, %{name: bot_name} = state) do
    messages = Map.get(state, :messages, ["Danger Zone"])
    send_message(Enum.random(messages), message.channel, slack)
    {:ok, state}
  end

  def handle_message(%{type: "message", text: "report!"} = message, slack, state) do
    send_message("#{state.name}: Reporting for Duty!", message.channel, slack)
    {:ok, state}
  end

  def handle_message(%{type: "message", text: "die"} = message, slack, state) do
    send_message("About to die y'all", message.channel, slack)
    1/0
    {:ok, state}
  end

  def handle_message(message, slack, state) do
    IO.inspect message
    {:ok, state}
  end
end
