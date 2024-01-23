CREATE TABLE users (
    id BIGINT AUTO_INCREMENT,
    type ENUM('advisor', 'applicant') NOT NULL,
    email VARCHAR(255) NOT NULL,
    username VARCHAR(255) NOT NULL,
    CONSTRAINT users_PK PRIMARY KEY (id),
    CONSTRAINT users_email_UQ UNIQUE (email),
    CONSTRAINT users_username_UQ UNIQUE (username)
);

CREATE TABLE advisors (
    user_id BIGINT,
    role ENUM('associate', 'partner', 'senior'),
    CONSTRAINT advisors_PK PRIMARY KEY (user_id),
    CONSTRAINT advisors_users_FK FOREIGN KEY (user_id) REFERENCES users ON DELETE CASCADE
);

CREATE TABLE applicants (
    user_id BIGINT,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    ssn VARCHAR(9) NOT NULL,
    CONSTRAINT applicants_PK PRIMARY KEY(user_id),
    CONSTRAINT applicants_users_FK FOREIGN KEY (user_id) REFERENCES users ON DELETE CASCADE
);

CREATE TABLE addresses (
    applicant_id BIGINT,
    zip VARCHAR(64) NOT NULL,
    city VARCHAR(255) NOT NULL,
    street varchar(512) NOT NULL,
    build_number VARCHAR(32),
    apt VARCHAR(32),
    CONSTRAINT addresses_PK PRIMARY KEY (applicant_id),
    CONSTRAINT addresses_users_FK FOREIGN KEY (applicant_id) REFERENCES users ON DELETE CASCADE
);

CREATE TABLE phone_numbers (
    id BIGINT AUTO_INCREMENT,
    applicant_id BIGINT NOT NULL,
    type ENUM('home', 'work', 'mobile') NOT NULL,
    number VARCHAR(32) NOT NULL,
    CONSTRAINT phone_numbers_PK PRIMARY KEY (id),
    CONSTRAINT phone_numbers_applicants_FK FOREIGN KEY (applicant_id) REFERENCES applicants ON DELETE CASCADE,
    CONSTRAINT phone_numbers_number_UQ UNIQUE (number)
);

CREATE TABLE applications (
    id BIGINT AUTO_INCREMENT,
    applicant_id BIGINT NOT NULL,
    money_amount NUMERIC(20,2) NOT NULL,
    status ENUM('new', 'assigned', 'on_hold', 'approved', 'canceled', 'declined') NOT NULL,
    created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    assigned TIMESTAMP,
    advisor_id BIGINT,
    CONSTRAINT applications_PK PRIMARY KEY (id),
    CONSTRAINT applications_applicants_FK FOREIGN KEY (applicant_id) REFERENCES applicants ON DELETE CASCADE,
    CONSTRAINT applications_advisors_FK FOREIGN KEY (advisor_id) REFERENCES advisors
);