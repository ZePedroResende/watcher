defmodule Watcher.Riot do
  import Watcher.Config, only: [config!: 2]

  @url "https://euw1.api.riotgames.com"
  def players_by_summoner(client, summoner_id) do
    Tesla.get(client, "/lol/clash/v1/players/by-summoner/" <> summoner_id)
  end

  def team_by_id(client, id) do
    Tesla.get(client, "/lol/clash/v1/teams/" <> id)
  end

  def tournaments(client) do
    Tesla.get(client, "/lol/clash/v1/tournaments")
  end

  def tournament_by_team_id(client, team_id) do
    Tesla.get(client, "/lol/clash/v1/tournaments/by-team/" <> team_id)
  end

  def tournaments_by_id(client, team_id) do
    Tesla.get(client, "/lol/clash/v1/tournaments/" <> team_id)
  end

  # build dynamic client based on runtime arguments
  def client do
    middleware = [
      {Tesla.Middleware.BaseUrl, @url},
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Headers, [{"authorization", "token: " <> get_api_key()}]}
    ]

    Tesla.client(middleware)
  end

  defp get_api_key, do: config!(__MODULE__, :api_key)
end
