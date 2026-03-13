import config from "../../config.json";
// Mapping des codes météo de l'api avec descriptions et numéros de fichiers svg vu que cette api ne nous donne que le code standardisé
const weatherMapping = {
  0: { description: "Ciel dégagé", icon: "01" },
  1: { description: "Principalement clair", icon: "02" },
  2: { description: "Partiellement nuageux", icon: "03" },
  3: { description: "Couvert", icon: "04" },
  45: { description: "Brouillard", icon: "50" },
  48: { description: "Brouillard givrant", icon: "50" },
  51: { description: "Bruine", icon: "09" },
  53: { description: "Bruine modérée", icon: "09" },
  55: { description: "Bruine dense", icon: "09" },
  61: { description: "Pluie légère", icon: "10" },
  63: { description: "Pluie modérée", icon: "10" },
  65: { description: "Pluie forte", icon: "10" },
  66: { description: "Pluie verglaçante", icon: "10" },
  67: { description: "Pluie verglaçante forte", icon: "10" },
  71: { description: "Neige légère", icon: "13" },
  73: { description: "Neige modérée", icon: "13" },
  75: { description: "Neige forte", icon: "13" },
  77: { description: "Grésil", icon: "13" },
  80: { description: "Averses de pluie", icon: "09" },
  81: { description: "Averses de pluie", icon: "09" },
  82: { description: "Averses de pluie", icon: "09" },
  85: { description: "Averses de neige", icon: "13" },
  86: { description: "Averses de neige", icon: "13" },
  95: { description: "Orage", icon: "11" },
  96: { description: "Orage avec grêle", icon: "11" },
  99: { description: "Orage violent", icon: "11" },
};
export default async function handler(req, res) {
  // Je bloque les autres méthodes même si pas de risque de sécu, convetion pour que l'API soit RESTful
  if (req.method !== "GET") {
    return res.status(405).json({ message: "Method Not Allowed" });
  }
  // Je récupère mes données de config.json mais pour cette version pas besoin du code Pays ou du nom de la Ville
  const { cityName, countryCode, latitude, longitude } = config;
  // À partir de la doc de l'API j'ai récupéré les mêmes infos et le temps dans current (dedans on a aussi le code météo et s'il fait jour/nuit ) puis précisé en UNIX et le vent en m/s comme sur l'autre APi
  const url = `https://api.open-meteo.com/v1/forecast?latitude=${latitude}&longitude=${longitude}&current=temperature_2m,relative_humidity_2m,apparent_temperature,weather_code,is_day,wind_speed_10m,wind_direction_10m,visibility&daily=sunrise,sunset&timezone=auto&timeformat=unixtime&wind_speed_unit=ms`;
  try {
    const response = await fetch(url);
    const rawData = await response.json();
    // console.log(rawData);
    // Je récupère le code pour l'icone météo et s'il fait jour ou nuit par la condition
    const code = rawData.current.weather_code;
    const isDaySuffix = rawData.current.is_day === 1 ? "d" : "n";
    // Je stocke les infos correspondant au code reçu par l'api et je prends en charge le cas où le code qui arrive est inhabituel / différent de ce que j'ai dans le dictionnaire
    const weatherInfo = weatherMapping[code] || {
      description: "Météo variable",
      icon: "03",
    };
    // J'adapte la donnée brute (RAW) pour qu'elle ressemble à ce que retournait l'API originale comme ça les composants savent toujours de quoi on parle
    const formattedData = {
      name: config.cityName || "Unkown",
      sys: {
        country: config.countryCode || "FR",
        // Je récupère les horaires du premier jour
        sunrise: rawData.daily.sunrise[0],
        sunset: rawData.daily.sunset[0],
      },
      // timestamp récupéré
      dt: rawData.current.time,
      timezone: rawData.utc_offset_seconds,
      main: {
        temp: rawData.current.temperature_2m,
        feels_like: rawData.current.apparent_temperature,
        humidity: rawData.current.relative_humidity_2m,
      },
      visibility: rawData.current.visibility,
      wind: {
        // Précisé en m/s dans le call à l'API pour avoir le même affichage qu'avec OpenWeather
        speed: rawData.current.wind_speed_10m,
        deg: rawData.current.wind_direction_10m,
      },
      weather: [
        {
          // Je récupère la description associée au code
          description: weatherInfo.description,
          // Je récupère le nom de l'icone et le suffixe jour/nuit pour créer le nom du .svg
          icon: `${weatherInfo.icon}${isDaySuffix}`,
        },
      ],
      // Je garde la réponse originale
      current: rawData.current,
    };
    res.status(200).json(formattedData);
    // console.log("current");

    // Si j'ai une erreur je la retourne
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Error fetching weather data" });
  }
}
