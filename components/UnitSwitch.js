import styles from "./UnitSwitch.module.css";

export const UnitSwitch = ({ onClick, unitSystem }) => {
  return (
    <div className={styles.wrapper}>
      <p
        className={`${styles.switch} ${
          unitSystem == "métrique" ? styles.active : styles.inactive
        }`}
        onClick={onClick}
      >
        Système Métrique
      </p>
      <p
        className={`${styles.switch} ${
          unitSystem == "métrique" ? styles.inactive : styles.active
        }`}
        onClick={onClick}
      >
        Système Impérial
      </p>
    </div>
  );
};
