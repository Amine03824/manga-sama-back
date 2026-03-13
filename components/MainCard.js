import Image from "next/image";
import { ctoF } from "../services/converters";
import styles from "./MainCard.module.css";

export const MainCard = ({
  city,
  country,
  description,
  iconName,
  unitSystem,
  weatherData,
}) => {
  return (
    <div className={styles.wrapper}>
      <h1 className={styles.location}>
        {city}, {country}
      </h1>
      <p className={styles.description}>{description}</p>
      <Image
        width="300px"
        height="300px"
        src={`/icons/${iconName}.svg`}
        alt="weatherIcon"
      />
      <h1 className={styles.temperature}>
        {unitSystem == "métrique"
          ? Math.round(weatherData.main.temp)
          : Math.round(ctoF(weatherData.main.temp))}
        °{unitSystem == "métrique" ? "C" : "F"}
      </h1>
      <p>
        Ressenti{" "}
        {unitSystem == "métrique"
          ? Math.round(weatherData.main.feels_like)
          : Math.round(ctoF(weatherData.main.feels_like))}
        °{unitSystem == "métrique" ? "C" : "F"}
      </p>
    </div>
  );
};
