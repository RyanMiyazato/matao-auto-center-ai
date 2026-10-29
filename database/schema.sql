--
-- PostgreSQL database dump
--

\restrict 1GcoIHc9zvwoFdTnvuFagX1MDXinRrBWRVpMya1XQefzwS5nnavPJx1P5CvSlTW

-- Dumped from database version 17.11 (Debian 17.11-1.pgdg13+2)
-- Dumped by pg_dump version 17.11 (Debian 17.11-1.pgdg13+2)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: agendamentos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.agendamentos (
    id integer NOT NULL,
    cliente_id integer NOT NULL,
    servico_id integer NOT NULL,
    data date NOT NULL,
    horario time without time zone NOT NULL,
    status character varying(30) DEFAULT 'agendado'::character varying,
    criado_em timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    recurso_id integer
);


--
-- Name: agendamentos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.agendamentos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: agendamentos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.agendamentos_id_seq OWNED BY public.agendamentos.id;


--
-- Name: atendimentos_humanos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.atendimentos_humanos (
    id integer NOT NULL,
    cliente_id integer,
    mensagem text,
    status character varying(30) DEFAULT 'aguardando'::character varying,
    criado_em timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    atendido_em timestamp without time zone
);


--
-- Name: atendimentos_humanos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.atendimentos_humanos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: atendimentos_humanos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.atendimentos_humanos_id_seq OWNED BY public.atendimentos_humanos.id;


--
-- Name: bloqueios_agenda; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bloqueios_agenda (
    id integer NOT NULL,
    empresa_id integer NOT NULL,
    data date NOT NULL,
    horario_inicio time without time zone,
    horario_fim time without time zone,
    dia_inteiro boolean DEFAULT false,
    motivo character varying(255),
    criado_em timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT bloqueios_agenda_check CHECK (((dia_inteiro = true) OR ((horario_inicio IS NOT NULL) AND (horario_fim IS NOT NULL) AND (horario_fim > horario_inicio))))
);


--
-- Name: bloqueios_agenda_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.bloqueios_agenda_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bloqueios_agenda_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.bloqueios_agenda_id_seq OWNED BY public.bloqueios_agenda.id;


--
-- Name: clientes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.clientes (
    id integer NOT NULL,
    nome character varying(150),
    telefone character varying(30) NOT NULL,
    criado_em timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    empresa_id integer NOT NULL
);


--
-- Name: clientes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.clientes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: clientes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.clientes_id_seq OWNED BY public.clientes.id;


--
-- Name: contexto_conversa; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contexto_conversa (
    id integer NOT NULL,
    empresa_id integer NOT NULL,
    cliente_id integer NOT NULL,
    intencao character varying(50),
    servico character varying(150),
    data date,
    horario time without time zone,
    aguardando character varying(50),
    atualizado_em timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: contexto_conversa_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.contexto_conversa_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contexto_conversa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.contexto_conversa_id_seq OWNED BY public.contexto_conversa.id;


--
-- Name: empresa; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.empresa (
    id integer NOT NULL,
    nome character varying(150) NOT NULL,
    descricao text,
    horario_segunda_sexta character varying(100),
    horario_sabado character varying(100),
    horario_domingo character varying(100),
    telefone character varying(30),
    endereco text,
    criado_em timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: empresa_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.empresa_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: empresa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.empresa_id_seq OWNED BY public.empresa.id;


--
-- Name: horarios_empresa; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.horarios_empresa (
    id integer NOT NULL,
    empresa_id integer NOT NULL,
    dia_semana integer NOT NULL,
    abertura time without time zone,
    fechamento time without time zone,
    ativo boolean DEFAULT true
);


--
-- Name: horarios_empresa_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.horarios_empresa_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: horarios_empresa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.horarios_empresa_id_seq OWNED BY public.horarios_empresa.id;


--
-- Name: mensagens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.mensagens (
    id integer NOT NULL,
    cliente_id integer,
    papel character varying(20) NOT NULL,
    conteudo text NOT NULL,
    criado_em timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    servico character varying(150)
);


--
-- Name: mensagens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.mensagens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: mensagens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.mensagens_id_seq OWNED BY public.mensagens.id;


--
-- Name: recursos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.recursos (
    id integer NOT NULL,
    empresa_id integer NOT NULL,
    nome character varying(150) NOT NULL,
    tipo character varying(100),
    ativo boolean DEFAULT true,
    criado_em timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: recursos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.recursos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: recursos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.recursos_id_seq OWNED BY public.recursos.id;


--
-- Name: servico_recursos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.servico_recursos (
    servico_id integer NOT NULL,
    recurso_id integer NOT NULL
);


--
-- Name: servicos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.servicos (
    id integer NOT NULL,
    nome character varying(150) NOT NULL,
    preco numeric(10,2),
    ativo boolean DEFAULT true,
    empresa_id integer NOT NULL,
    duracao_minutos integer DEFAULT 60
);


--
-- Name: servicos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.servicos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: servicos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.servicos_id_seq OWNED BY public.servicos.id;


--
-- Name: agendamentos id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agendamentos ALTER COLUMN id SET DEFAULT nextval('public.agendamentos_id_seq'::regclass);


--
-- Name: atendimentos_humanos id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.atendimentos_humanos ALTER COLUMN id SET DEFAULT nextval('public.atendimentos_humanos_id_seq'::regclass);


--
-- Name: bloqueios_agenda id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bloqueios_agenda ALTER COLUMN id SET DEFAULT nextval('public.bloqueios_agenda_id_seq'::regclass);


--
-- Name: clientes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clientes ALTER COLUMN id SET DEFAULT nextval('public.clientes_id_seq'::regclass);


--
-- Name: contexto_conversa id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contexto_conversa ALTER COLUMN id SET DEFAULT nextval('public.contexto_conversa_id_seq'::regclass);


--
-- Name: empresa id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.empresa ALTER COLUMN id SET DEFAULT nextval('public.empresa_id_seq'::regclass);


--
-- Name: horarios_empresa id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.horarios_empresa ALTER COLUMN id SET DEFAULT nextval('public.horarios_empresa_id_seq'::regclass);


--
-- Name: mensagens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mensagens ALTER COLUMN id SET DEFAULT nextval('public.mensagens_id_seq'::regclass);


--
-- Name: recursos id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recursos ALTER COLUMN id SET DEFAULT nextval('public.recursos_id_seq'::regclass);


--
-- Name: servicos id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.servicos ALTER COLUMN id SET DEFAULT nextval('public.servicos_id_seq'::regclass);


--
-- Name: agendamentos agendamentos_data_horario_recurso_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agendamentos
    ADD CONSTRAINT agendamentos_data_horario_recurso_key UNIQUE (data, horario, recurso_id);


--
-- Name: agendamentos agendamentos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agendamentos
    ADD CONSTRAINT agendamentos_pkey PRIMARY KEY (id);


--
-- Name: atendimentos_humanos atendimentos_humanos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.atendimentos_humanos
    ADD CONSTRAINT atendimentos_humanos_pkey PRIMARY KEY (id);


--
-- Name: bloqueios_agenda bloqueios_agenda_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bloqueios_agenda
    ADD CONSTRAINT bloqueios_agenda_pkey PRIMARY KEY (id);


--
-- Name: clientes clientes_empresa_telefone_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_empresa_telefone_unique UNIQUE (empresa_id, telefone);


--
-- Name: clientes clientes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_pkey PRIMARY KEY (id);


--
-- Name: contexto_conversa contexto_conversa_empresa_id_cliente_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contexto_conversa
    ADD CONSTRAINT contexto_conversa_empresa_id_cliente_id_key UNIQUE (empresa_id, cliente_id);


--
-- Name: contexto_conversa contexto_conversa_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contexto_conversa
    ADD CONSTRAINT contexto_conversa_pkey PRIMARY KEY (id);


--
-- Name: empresa empresa_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.empresa
    ADD CONSTRAINT empresa_pkey PRIMARY KEY (id);


--
-- Name: horarios_empresa horarios_empresa_empresa_id_dia_semana_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.horarios_empresa
    ADD CONSTRAINT horarios_empresa_empresa_id_dia_semana_key UNIQUE (empresa_id, dia_semana);


--
-- Name: horarios_empresa horarios_empresa_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.horarios_empresa
    ADD CONSTRAINT horarios_empresa_pkey PRIMARY KEY (id);


--
-- Name: mensagens mensagens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mensagens
    ADD CONSTRAINT mensagens_pkey PRIMARY KEY (id);


--
-- Name: recursos recursos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recursos
    ADD CONSTRAINT recursos_pkey PRIMARY KEY (id);


--
-- Name: servico_recursos servico_recursos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.servico_recursos
    ADD CONSTRAINT servico_recursos_pkey PRIMARY KEY (servico_id, recurso_id);


--
-- Name: servicos servicos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.servicos
    ADD CONSTRAINT servicos_pkey PRIMARY KEY (id);


--
-- Name: agendamentos agendamentos_cliente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agendamentos
    ADD CONSTRAINT agendamentos_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.clientes(id);


--
-- Name: agendamentos agendamentos_recurso_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agendamentos
    ADD CONSTRAINT agendamentos_recurso_id_fkey FOREIGN KEY (recurso_id) REFERENCES public.recursos(id);


--
-- Name: agendamentos agendamentos_servico_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agendamentos
    ADD CONSTRAINT agendamentos_servico_id_fkey FOREIGN KEY (servico_id) REFERENCES public.servicos(id);


--
-- Name: atendimentos_humanos atendimentos_humanos_cliente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.atendimentos_humanos
    ADD CONSTRAINT atendimentos_humanos_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.clientes(id);


--
-- Name: bloqueios_agenda bloqueios_agenda_empresa_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bloqueios_agenda
    ADD CONSTRAINT bloqueios_agenda_empresa_id_fkey FOREIGN KEY (empresa_id) REFERENCES public.empresa(id);


--
-- Name: clientes clientes_empresa_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_empresa_id_fkey FOREIGN KEY (empresa_id) REFERENCES public.empresa(id);


--
-- Name: contexto_conversa contexto_conversa_cliente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contexto_conversa
    ADD CONSTRAINT contexto_conversa_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.clientes(id);


--
-- Name: contexto_conversa contexto_conversa_empresa_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contexto_conversa
    ADD CONSTRAINT contexto_conversa_empresa_id_fkey FOREIGN KEY (empresa_id) REFERENCES public.empresa(id);


--
-- Name: horarios_empresa horarios_empresa_empresa_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.horarios_empresa
    ADD CONSTRAINT horarios_empresa_empresa_id_fkey FOREIGN KEY (empresa_id) REFERENCES public.empresa(id);


--
-- Name: mensagens mensagens_cliente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mensagens
    ADD CONSTRAINT mensagens_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.clientes(id);


--
-- Name: recursos recursos_empresa_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recursos
    ADD CONSTRAINT recursos_empresa_id_fkey FOREIGN KEY (empresa_id) REFERENCES public.empresa(id);


--
-- Name: servico_recursos servico_recursos_recurso_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.servico_recursos
    ADD CONSTRAINT servico_recursos_recurso_id_fkey FOREIGN KEY (recurso_id) REFERENCES public.recursos(id);


--
-- Name: servico_recursos servico_recursos_servico_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.servico_recursos
    ADD CONSTRAINT servico_recursos_servico_id_fkey FOREIGN KEY (servico_id) REFERENCES public.servicos(id);


--
-- Name: servicos servicos_empresa_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.servicos
    ADD CONSTRAINT servicos_empresa_id_fkey FOREIGN KEY (empresa_id) REFERENCES public.empresa(id);


--
-- PostgreSQL database dump complete
--

\unrestrict 1GcoIHc9zvwoFdTnvuFagX1MDXinRrBWRVpMya1XQefzwS5nnavPJx1P5CvSlTW

