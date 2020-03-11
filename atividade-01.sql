-- > Criado por Hugo Hoffmann - 11/03/2020
-- > https://github.com/hugohoffmann035
-- > Cria Banco de Dados
create database if not exists porjetos
default charset utf8
default collate utf8_general_ci;

use porjetos;

-- > Deleta Tabelas
drop table if exists projetos;
drop table if exists empregados;
drop table if exists setores;
drop table if exists cargos;
drop table if exists cargos_empregados;
drop table if exists setores_empregados;
drop table if exists projeto_empregados;

-- > Cria Tabelas
CREATE TABLE IF NOT EXISTS projeto_empregados (
	codigo_projeto INT(11) NOT NULL,
	codigo_empregado INT(11) NOT NULL,
    INDEX IDX_projeto_empregados_codigo_projeto (codigo_projeto),
    INDEX IDX_projeto_empregados_codigo_empregado (codigo_empregado),
	PRIMARY KEY (codigo_projeto, codigo_empregado)
) DEFAULT CHARSET UTF8
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS cargos_empregados (
	codigo_cargo INT(11) NOT NULL,
    codigo_empregado INT(11) NOT NULL,
    INDEX IDX_cargos_empregados_codigo_cargo (codigo_cargo),
    INDEX IDX_cargos_empregados_codigo_empregado (codigo_empregado),
    PRIMARY KEY (codigo_cargo, codigo_empregado)
) DEFAULT CHARSET UTF8 ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS setores_empregados (
	codigo_setores INT(11) NOT NULL,
    codigo_empregado INT(11) NOT NULL,
    INDEX IDX_setores_empregados_codigo_setores (codigo_setores),
    INDEX IDX_setores_empregados_codigo_empregado (codigo_empregado),
    PRIMARY KEY (codigo_setores, codigo_empregado)
) DEFAULT CHARSET UTF8 ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS setores (
	codigo INT(11) NOT NULL AUTO_INCREMENT,
	codigo_projeto INT(11) NOT NULL,
	descricao TEXT NOT NULL,
    INDEX IDX_setores_codigo (codigo),
    INDEX IDX_setores_codigo_projeto (codigo_projeto),
	PRIMARY KEY (codigo),
    CONSTRAINT FK_setores_codigo FOREIGN KEY IDX_setores_codigo (codigo) REFERENCES setores_empregados (codigo_setores)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION
) DEFAULT CHARSET UTF8
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS cargos (
	codigo INT(11) NOT NULL AUTO_INCREMENT,
    codigo_projeto INT(11) NOT NULL,
	descricao TEXT NOT NULL,
	valor_salatio DECIMAL(12,2) NULL DEFAULT 0,
    INDEX IDX_cargos_codigo (codigo),
    INDEX IDX_cargos_codigo_projeto (codigo_projeto),
    PRIMARY KEY (codigo),
    CONSTRAINT FK_cargos_empregados_codigo FOREIGN KEY IDX_cargos_codigo (codigo) REFERENCES cargos_empregados (codigo_cargo)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION
) DEFAULT CHARSET UTF8
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS empregados (
	codigo INT(11) NOT NULL AUTO_INCREMENT,
	nome VARCHAR(45) NOT NULL,
    INDEX IDX_empregados_codigo (codigo),
	PRIMARY KEY (codigo),
    CONSTRAINT FK_projeto_empregados_codigo FOREIGN KEY IDX_empregados_codigo (codigo) REFERENCES projeto_empregados (codigo_empregado)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
    CONSTRAINT FK_cargos_empregados_codigo_empregado FOREIGN KEY IDX_empregados_codigo (codigo) REFERENCES cargos_empregados (codigo_empregado)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION
) DEFAULT CHARSET UTF8
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS projetos (
	codigo INT(11) NOT NULL AUTO_INCREMENT,
	abreviatura VARCHAR(45) NOT NULL,
	descricao TEXT NOT NULL,
    INDEX IDX_projetos_codigo (codigo),
	PRIMARY KEY (codigo),
    CONSTRAINT FK_setores_codigo_projeto FOREIGN KEY IDX_projetos_codigo (codigo) REFERENCES setores (codigo_projeto)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
    CONSTRAINT FK_cargos_codigo_projeto FOREIGN KEY IDX_projetos_codigo (codigo) REFERENCES cargos (codigo_projeto)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION
) DEFAULT CHARSET UTF8 
ENGINE = InnoDB;