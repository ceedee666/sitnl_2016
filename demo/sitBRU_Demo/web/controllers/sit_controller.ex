defmodule SitBRU_Demo.SitController do
  require Logger

  use SitBRU_Demo.Web, :controller

  def index(conn, _params) do
    data = []
    config = Application.get_env( :sitBRU_Demo, HCP_IOT_Services )
    auth  = [basic_auth: {System.get_env("HCP_USER_NAME"), System.get_env("HCP_PASSWD")}]

    case HTTPoison.get("https://iotmmsp650074trial.hanatrial.ondemand.com/com.sap.iotservices.mms/v1/api/http/app.svc/NEO_C2RX38OZZV5FRLDH344OTBPP2.T_IOT_B957CB9F60C087A144A5?$format=json", [],  [hackney: auth]) do
      {:ok, %HTTPoison.Response{body: body, status_code: 200}} ->
        json = Poison.Parser.parse!(body)["d"]["results"]
        data = Enum.map(json, fn(entry) -> %{humidity: entry["C_HUMIDITY"],temperature: entry["C_TEMPERATURE"]} end)

      {:ok, %HTTPoison.Response{status_code: 401}} ->
        Logger.error "Could not access HCP IoT Service. HTTP 401"

      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error "An error occured accessing HCP IoT Service. #{inspect reason}"
    end

    render conn, "index.html", data: data

    #render conn, "index.html"
  end
end
