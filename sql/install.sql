CREATE TABLE IF NOT EXISTS rds_weapon_serials (
    id INT AUTO_INCREMENT PRIMARY KEY,
    citizenid VARCHAR(50),
    player_name VARCHAR(100),
    job VARCHAR(50),
    job_grade INT,
    item VARCHAR(100),
    label VARCHAR(100),
    category VARCHAR(50),
    tier VARCHAR(50),
    serial VARCHAR(100),
    amount INT,
    materials TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS rds_player_craft_totals (
    citizenid VARCHAR(50) PRIMARY KEY,
    player_name VARCHAR(100),
    melee INT DEFAULT 0,
    firearms INT DEFAULT 0,
    attachments INT DEFAULT 0,
    ammo INT DEFAULT 0,
    tints INT DEFAULT 0,
    throwables INT DEFAULT 0,
    total INT DEFAULT 0,
    photo_url VARCHAR(255),
    license_issued TINYINT(1) DEFAULT 0,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
