BEGIN;

CREATE TABLE IF NOT EXISTS public."Аудитории"
(
    "Код_аудитории" SERIAL PRIMARY KEY,
    "Номер_аудитории" VARCHAR(50) NOT NULL,
    "Код_корпуса" INTEGER,
    "Тип_аудитории" VARCHAR(50) NOT NULL,
    "Количество_посадочных_мест" INTEGER NOT NULL,
    "Меловая_доска" BOOLEAN NOT NULL,
    "Маркерная_доска" BOOLEAN NOT NULL,
    "Видео_проектор" BOOLEAN NOT NULL,
    "Компьютерный_класс" BOOLEAN NOT NULL,
    "Лабораторное_оборудование" BOOLEAN NOT NULL,
    "Код_кафедры" INTEGER,
    CONSTRAINT "Аудитории_Корпуса_внешний_ключ" FOREIGN KEY ("Код_корпуса")
        REFERENCES public."Корпусы" ("Код_корпуса")
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT "Аудитории_Кафедры_внешний_ключ" FOREIGN KEY ("Код_кафедры")
        REFERENCES public."Кафедры" ("Код_кафедры")
        ON UPDATE SET NULL
        ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS public."Факультеты"
(
    "Код_факультета" SERIAL PRIMARY KEY,
    "Название_факультета" VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS public."Учебный_план"
(
    "Код_учебного_плана" SERIAL PRIMARY KEY,
    "Код_специальности" INTEGER,
    "Курс" INTEGER NOT NULL,
    "Продолжительность_семестра" INTEGER NOT NULL,
    "Название_дисциплины" VARCHAR(100) NOT NULL,
    "Тип_занятия" VARCHAR(50) NOT NULL,
    "Количество_занятий_в_неделю" INTEGER NOT NULL,
    "Форма_контроля" VARCHAR(50) NOT NULL,
    "ФИО_преподавателя" VARCHAR(100) NOT NULL,
    CONSTRAINT "Учебный_план_Специальности_внешний_ключ" FOREIGN KEY ("Код_специальности")
        REFERENCES public."Специальности" ("Код_специальности")
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS public."Специальности"
(
    "Код_специальности" SERIAL PRIMARY KEY,
    "Название_специальности" VARCHAR(100) NOT NULL,
    "Код_факультета" INTEGER,
    CONSTRAINT "Специальности_Факультеты_внешний_ключ" FOREIGN KEY ("Код_факультета")
        REFERENCES public."Факультеты" ("Код_факультета")
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS public."Расписания_звонков"
(
    "Код_расписания" SERIAL PRIMARY KEY,
    "Название_расписания" VARCHAR(100) NOT NULL,
    "Количество_уроков" INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS public."Расписание"
(
    "Код_расписания" SERIAL PRIMARY KEY,
    "Код_учебного_плана" INTEGER,
    "Верхняя_неделя" DATE NOT NULL,
    "Нижняя_неделя" DATE NOT NULL,
    CONSTRAINT "Расписание_Учебный_план_внешний_ключ" FOREIGN KEY ("Код_учебного_плана")
        REFERENCES public."Учебный_план" ("Код_учебного_плана")
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS public."Преподаватели"
(
    "Код_преподавателя" SERIAL PRIMARY KEY,
    "ФИО_преподавателя" VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS public."Корпусы"
(
    "Код_корпуса" SERIAL PRIMARY KEY,
    "Название_корпуса" VARCHAR(100) NOT NULL,
    "Аббревиатура_корпуса" VARCHAR(10) NOT NULL
);

CREATE TABLE IF NOT EXISTS public."Кафедры"
(
    "Код_кафедры" SERIAL PRIMARY KEY,
    "Название_кафедры" VARCHAR(100) NOT NULL,
    "Закрепленные_аудитории" INTEGER[]
);

CREATE TABLE IF NOT EXISTS public."Занятия"
(
    "Код_занятия" SERIAL PRIMARY KEY,
    "Код_расписания" INTEGER,
    "Дата" DATE NOT NULL,
    "Время" TIME NOT NULL,
    "Код_группы" INTEGER,
    "Код_аудитории" INTEGER,
    "Код_преподавателя" INTEGER,
    CONSTRAINT "Занятия_Расписание_внешний_ключ" FOREIGN KEY ("Код_расписания")
        REFERENCES public."Расписание" ("Код_расписания")
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT "Занятия_Группы_внешний_ключ" FOREIGN KEY ("Код_группы")
        REFERENCES public."Группы" ("Код_группы")
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT "Занятия_Аудитории_внешний_ключ" FOREIGN KEY ("Код_аудитории")
        REFERENCES public."Аудитории" ("Код_аудитории")
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT "Занятия_Преподаватели_внешний_ключ" FOREIGN KEY ("Код_преподавателя")
        REFERENCES public."Преподаватели" ("Код_преподавателя")
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS public."Группы"
(
    "Код_группы" SERIAL PRIMARY KEY,
    "Название_группы" VARCHAR(100) NOT NULL,
    "Код_специальности" INTEGER,
    "Курс" INTEGER NOT NULL,
    CONSTRAINT "Группы_Специальности_внешний_ключ" FOREIGN KEY ("Код_специальности")
        REFERENCES public."Специальности" ("Код_специальности")
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

COMMIT;
