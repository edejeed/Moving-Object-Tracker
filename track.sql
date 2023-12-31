PGDMP     (                    {            track    15.2    15.2                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    69859    track    DATABASE     ~   CREATE DATABASE track WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_Philippines.1252';
    DROP DATABASE track;
                postgres    false            �            1255    69917    get_all_bird_locations()    FUNCTION     D  CREATE FUNCTION public.get_all_bird_locations() RETURNS json
    LANGUAGE plpgsql
    AS $$
DECLARE
    result_json JSON;
BEGIN
    SELECT json_agg(row_to_json(t))
    INTO result_json
    FROM (
        SELECT bird_id, location_id, lat, lng, timestamp
        FROM bird_locations
    ) t;

    RETURN result_json;
END;
$$;
 /   DROP FUNCTION public.get_all_bird_locations();
       public          postgres    false            �            1255    69938    get_all_sites_json()    FUNCTION     �   CREATE FUNCTION public.get_all_sites_json() RETURNS json
    LANGUAGE plpgsql
    AS $$
DECLARE
    result_json JSON;
BEGIN
    SELECT json_agg(row_to_json(sites)) INTO result_json FROM sites;
    RETURN result_json;
END;
$$;
 +   DROP FUNCTION public.get_all_sites_json();
       public          postgres    false            �            1255    69908    get_coordinates()    FUNCTION     �   CREATE FUNCTION public.get_coordinates() RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    result_json jsonb;
BEGIN
    SELECT jsonb_agg(row_to_json(bird_location))
    INTO result_json
    FROM bird_location;
    
    RETURN result_json;
END;
$$;
 (   DROP FUNCTION public.get_coordinates();
       public          postgres    false            �            1255    69930    group_bird_locations()    FUNCTION     |  CREATE FUNCTION public.group_bird_locations() RETURNS TABLE(bird_id integer, latitudes double precision[], longitudes double precision[])
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        bl.bird_id,
        ARRAY_AGG(bl.lat) AS latitudes,
        ARRAY_AGG(bl.lng) AS longitudes
    FROM
        bird_locations bl
    GROUP BY
        bl.bird_id;
END;
$$;
 -   DROP FUNCTION public.group_bird_locations();
       public          postgres    false            �            1259    69910    bird_locations    TABLE     �   CREATE TABLE public.bird_locations (
    location_id integer NOT NULL,
    bird_id integer NOT NULL,
    lat double precision NOT NULL,
    lng double precision NOT NULL,
    "timestamp" timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 "   DROP TABLE public.bird_locations;
       public         heap    postgres    false            �            1259    69909    bird_locations_location_id_seq    SEQUENCE     �   CREATE SEQUENCE public.bird_locations_location_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.bird_locations_location_id_seq;
       public          postgres    false    215                       0    0    bird_locations_location_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.bird_locations_location_id_seq OWNED BY public.bird_locations.location_id;
          public          postgres    false    214            �            1259    69919 
   signatures    TABLE     A   CREATE TABLE public.signatures (
    bird_id integer NOT NULL
);
    DROP TABLE public.signatures;
       public         heap    postgres    false            �            1259    69918    signatures_bird_id_seq    SEQUENCE     �   CREATE SEQUENCE public.signatures_bird_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.signatures_bird_id_seq;
       public          postgres    false    217                       0    0    signatures_bird_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.signatures_bird_id_seq OWNED BY public.signatures.bird_id;
          public          postgres    false    216            �            1259    69932    sites    TABLE     �   CREATE TABLE public.sites (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    latitude double precision NOT NULL,
    longitude double precision NOT NULL
);
    DROP TABLE public.sites;
       public         heap    postgres    false            �            1259    69931    sites_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sites_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.sites_id_seq;
       public          postgres    false    219                       0    0    sites_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.sites_id_seq OWNED BY public.sites.id;
          public          postgres    false    218            s           2604    69913    bird_locations location_id    DEFAULT     �   ALTER TABLE ONLY public.bird_locations ALTER COLUMN location_id SET DEFAULT nextval('public.bird_locations_location_id_seq'::regclass);
 I   ALTER TABLE public.bird_locations ALTER COLUMN location_id DROP DEFAULT;
       public          postgres    false    214    215    215            u           2604    69922    signatures bird_id    DEFAULT     x   ALTER TABLE ONLY public.signatures ALTER COLUMN bird_id SET DEFAULT nextval('public.signatures_bird_id_seq'::regclass);
 A   ALTER TABLE public.signatures ALTER COLUMN bird_id DROP DEFAULT;
       public          postgres    false    217    216    217            v           2604    69935    sites id    DEFAULT     d   ALTER TABLE ONLY public.sites ALTER COLUMN id SET DEFAULT nextval('public.sites_id_seq'::regclass);
 7   ALTER TABLE public.sites ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    219    218    219                      0    69910    bird_locations 
   TABLE DATA           U   COPY public.bird_locations (location_id, bird_id, lat, lng, "timestamp") FROM stdin;
    public          postgres    false    215   �#                 0    69919 
   signatures 
   TABLE DATA           -   COPY public.signatures (bird_id) FROM stdin;
    public          postgres    false    217   U$                 0    69932    sites 
   TABLE DATA           >   COPY public.sites (id, name, latitude, longitude) FROM stdin;
    public          postgres    false    219   v$                  0    0    bird_locations_location_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.bird_locations_location_id_seq', 4, true);
          public          postgres    false    214                       0    0    signatures_bird_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.signatures_bird_id_seq', 2, true);
          public          postgres    false    216                       0    0    sites_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.sites_id_seq', 2, true);
          public          postgres    false    218            x           2606    69916 "   bird_locations bird_locations_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.bird_locations
    ADD CONSTRAINT bird_locations_pkey PRIMARY KEY (location_id);
 L   ALTER TABLE ONLY public.bird_locations DROP CONSTRAINT bird_locations_pkey;
       public            postgres    false    215            z           2606    69924    signatures signatures_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.signatures
    ADD CONSTRAINT signatures_pkey PRIMARY KEY (bird_id);
 D   ALTER TABLE ONLY public.signatures DROP CONSTRAINT signatures_pkey;
       public            postgres    false    217            |           2606    69937    sites sites_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.sites
    ADD CONSTRAINT sites_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.sites DROP CONSTRAINT sites_pkey;
       public            postgres    false    219            }           2606    69925    bird_locations signature    FK CONSTRAINT     �   ALTER TABLE ONLY public.bird_locations
    ADD CONSTRAINT signature FOREIGN KEY (bird_id) REFERENCES public.signatures(bird_id) NOT VALID;
 B   ALTER TABLE ONLY public.bird_locations DROP CONSTRAINT signature;
       public          postgres    false    3194    215    217               �   x�]��B1C�uR�x<��B�u��B^����Q�%Y����Y��Fڀ��RO�lӷ�2������Rχ�a��Կ�z�#�}�2�L2#�
�t�~�|�l�	Y��ɁoE�!��.�*MK6��0l���k�9��3�            x�3�2����� l          O   x�ʡ�0���0؃lZ0�Ͳd���z��
��1��S��s��lps��f�#.`�e\���P���y*���_�>�     