-- Sample Store catalog seed for FusionCMS
-- Safe to run multiple times (uses WHERE NOT EXISTS checks)

USE `fusioncms`;

SET @realm := 1;

-- ----------------------------
-- Store groups (categories)
-- ----------------------------

INSERT INTO `store_groups` (`title`, `icon`, `orderNumber`)
SELECT 'Monturas', 'ability_mount_ridinghorse', 10
WHERE NOT EXISTS (SELECT 1 FROM `store_groups` WHERE `title` = 'Monturas');

INSERT INTO `store_groups` (`title`, `icon`, `orderNumber`)
SELECT 'Mascotas', 'inv_box_petcarrier_01', 20
WHERE NOT EXISTS (SELECT 1 FROM `store_groups` WHERE `title` = 'Mascotas');

INSERT INTO `store_groups` (`title`, `icon`, `orderNumber`)
SELECT 'Transfiguracion', 'inv_chest_cloth_21', 30
WHERE NOT EXISTS (SELECT 1 FROM `store_groups` WHERE `title` = 'Transfiguracion');

INSERT INTO `store_groups` (`title`, `icon`, `orderNumber`)
SELECT 'Consumibles', 'inv_potion_54', 40
WHERE NOT EXISTS (SELECT 1 FROM `store_groups` WHERE `title` = 'Consumibles');

INSERT INTO `store_groups` (`title`, `icon`, `orderNumber`)
SELECT 'Servicios', 'inv_scroll_06', 50
WHERE NOT EXISTS (SELECT 1 FROM `store_groups` WHERE `title` = 'Servicios');

INSERT INTO `store_groups` (`title`, `icon`, `orderNumber`)
SELECT 'Paquetes', 'inv_misc_bag_10', 60
WHERE NOT EXISTS (SELECT 1 FROM `store_groups` WHERE `title` = 'Paquetes');

SET @gid_mounts   := (SELECT `id` FROM `store_groups` WHERE `title`='Monturas' LIMIT 1);
SET @gid_pets     := (SELECT `id` FROM `store_groups` WHERE `title`='Mascotas' LIMIT 1);
SET @gid_transmog := (SELECT `id` FROM `store_groups` WHERE `title`='Transfiguracion' LIMIT 1);
SET @gid_cons     := (SELECT `id` FROM `store_groups` WHERE `title`='Consumibles' LIMIT 1);
SET @gid_serv     := (SELECT `id` FROM `store_groups` WHERE `title`='Servicios' LIMIT 1);
SET @gid_bundles  := (SELECT `id` FROM `store_groups` WHERE `title`='Paquetes' LIMIT 1);

-- ----------------------------
-- Store items
-- Notes:
-- - itemid/itemcount are left as simple single values
-- - tooltip=0 so the storefront doesn't depend on external tooltip sources
-- ----------------------------

-- Monturas
INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`)
SELECT '28483','1','[Ejemplo] Montura - Corcel de batalla',4,50,0,@realm,'Montura de ejemplo para probar el layout.','ability_mount_ridinghorse',@gid_mounts,0
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Montura - Corcel de batalla' AND `realm`=@realm);

INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`)
SELECT '28484','1','[Ejemplo] Montura - Bestia blindada',4,60,0,@realm,'Montura de ejemplo (blindada).','ability_mount_charger',@gid_mounts,0
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Montura - Bestia blindada' AND `realm`=@realm);

INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`)
SELECT '28485','1','[Ejemplo] Montura - Vuelapluma',3,40,0,@realm,'Montura de ejemplo (rápida).','ability_mount_raptor',@gid_mounts,0
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Montura - Vuelapluma' AND `realm`=@realm);

INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`)
SELECT '28486','1','[Ejemplo] Montura - Lobo de guerra',3,35,0,@realm,'Montura terrestre de ejemplo.','ability_mount_blackdirewolf',@gid_mounts,0
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Montura - Lobo de guerra' AND `realm`=@realm);

INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`)
SELECT '28487','1','[Ejemplo] Montura - Felino sigiloso',4,55,0,@realm,'Montura felina de ejemplo.','ability_mount_jungletiger',@gid_mounts,0
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Montura - Felino sigiloso' AND `realm`=@realm);

INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`)
SELECT '28488','1','[Ejemplo] Montura - Carnero robusto',3,30,0,@realm,'Montura de ejemplo (carnero).','ability_mount_mountainram',@gid_mounts,0
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Montura - Carnero robusto' AND `realm`=@realm);

INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`)
SELECT '28489','1','[Ejemplo] Montura - Bestia alada',4,70,0,@realm,'Montura voladora de ejemplo.','ability_mount_drake_blue',@gid_mounts,0
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Montura - Bestia alada' AND `realm`=@realm);

INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`)
SELECT '28490','1','[Ejemplo] Montura - Mecanoestrider',3,45,0,@realm,'Montura mecanica de ejemplo.','ability_mount_mechastrider',@gid_mounts,0
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Montura - Mecanoestrider' AND `realm`=@realm);

-- Mascotas
INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`)
SELECT '29901','1','[Ejemplo] Mascota - Dragón bebé',3,15,0,@realm,'Mascota de ejemplo para probar categorías.','inv_pet_babybluedragon',@gid_pets,0
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Mascota - Dragón bebé' AND `realm`=@realm);

INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`)
SELECT '29902','1','[Ejemplo] Mascota - Conejo curioso',2,10,0,@realm,'Mascota de ejemplo.','inv_pet_bunny',@gid_pets,0
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Mascota - Conejo curioso' AND `realm`=@realm);

INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`)
SELECT '29903','1','[Ejemplo] Mascota - Serpiente',2,10,0,@realm,'Mascota de ejemplo.','inv_pet_snake',@gid_pets,0
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Mascota - Serpiente' AND `realm`=@realm);

INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`)
SELECT '29904','1','[Ejemplo] Mascota - Robotito',3,18,0,@realm,'Mascota mecánica de ejemplo.','inv_pet_lilsmoky',@gid_pets,0
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Mascota - Robotito' AND `realm`=@realm);

INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`)
SELECT '29905','1','[Ejemplo] Mascota - Gatito',2,12,0,@realm,'Mascota de ejemplo.','inv_pet_cat',@gid_pets,0
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Mascota - Gatito' AND `realm`=@realm);

INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`)
SELECT '29906','1','[Ejemplo] Mascota - Murciélago',2,12,0,@realm,'Mascota de ejemplo.','inv_pet_bat',@gid_pets,0
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Mascota - Murciélago' AND `realm`=@realm);

INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`)
SELECT '29907','1','[Ejemplo] Mascota - Mini elemental',3,20,0,@realm,'Mascota mágica de ejemplo.','inv_elemental_primal_water',@gid_pets,0
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Mascota - Mini elemental' AND `realm`=@realm);

INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`)
SELECT '29908','1','[Ejemplo] Mascota - Ave exótica',3,16,0,@realm,'Mascota de ejemplo.','inv_pet_pinkmurlocegg',@gid_pets,0
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Mascota - Ave exótica' AND `realm`=@realm);

-- Transfiguración
INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`)
SELECT '31000','1','[Ejemplo] Transmog - Set de guerrero',4,25,0,@realm,'Set visual de ejemplo.','inv_chest_plate11',@gid_transmog,0
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Transmog - Set de guerrero' AND `realm`=@realm);

INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`)
SELECT '31001','1','[Ejemplo] Transmog - Set de mago',4,25,0,@realm,'Set visual de ejemplo.','inv_chest_cloth_21',@gid_transmog,0
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Transmog - Set de mago' AND `realm`=@realm);

INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`)
SELECT '31002','1','[Ejemplo] Transmog - Set de cazador',4,25,0,@realm,'Set visual de ejemplo.','inv_chest_chain_15',@gid_transmog,0
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Transmog - Set de cazador' AND `realm`=@realm);

INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`)
SELECT '31003','1','[Ejemplo] Transmog - Arma resplandeciente',4,30,0,@realm,'Arma visual de ejemplo.','inv_sword_04',@gid_transmog,0
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Transmog - Arma resplandeciente' AND `realm`=@realm);

INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`)
SELECT '31004','1','[Ejemplo] Transmog - Escudo antiguo',3,18,0,@realm,'Escudo visual de ejemplo.','inv_shield_05',@gid_transmog,0
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Transmog - Escudo antiguo' AND `realm`=@realm);

INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`)
SELECT '31005','1','[Ejemplo] Transmog - Capucha oscura',3,16,0,@realm,'Casco visual de ejemplo.','inv_helmet_06',@gid_transmog,0
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Transmog - Capucha oscura' AND `realm`=@realm);

INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`)
SELECT '31006','1','[Ejemplo] Transmog - Hombros épicos',4,22,0,@realm,'Hombros visuales de ejemplo.','inv_shoulder_25',@gid_transmog,0
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Transmog - Hombros épicos' AND `realm`=@realm);

INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`)
SELECT '31007','1','[Ejemplo] Transmog - Tunica legendaria',5,40,0,@realm,'Pieza visual de ejemplo.','inv_chest_cloth_17',@gid_transmog,0
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Transmog - Tunica legendaria' AND `realm`=@realm);

-- Consumibles
INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`)
SELECT '32000','5','[Ejemplo] Pack - Pociones (x5)',1,5,0,@realm,'Pack para testear cantidades.','inv_potion_54',@gid_cons,0
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Pack - Pociones (x5)' AND `realm`=@realm);

INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`)
SELECT '32001','10','[Ejemplo] Pack - Comida (x10)',1,6,0,@realm,'Consumibles de ejemplo.','inv_misc_food_64',@gid_cons,0
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Pack - Comida (x10)' AND `realm`=@realm);

INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`)
SELECT '32002','5','[Ejemplo] Pack - Elixires (x5)',2,8,0,@realm,'Consumibles de ejemplo.','inv_potion_63',@gid_cons,0
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Pack - Elixires (x5)' AND `realm`=@realm);

INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`)
SELECT '32003','20','[Ejemplo] Pack - Munición (x20)',1,4,0,@realm,'Consumibles de ejemplo.','inv_ammo_arrow_01',@gid_cons,0
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Pack - Munición (x20)' AND `realm`=@realm);

INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`)
SELECT '32004','1','[Ejemplo] Pergamino - Utilidad',1,3,0,@realm,'Consumible de ejemplo.','inv_scroll_03',@gid_cons,0
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Pergamino - Utilidad' AND `realm`=@realm);

INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`)
SELECT '32005','3','[Ejemplo] Pack - Vendas (x3)',1,3,0,@realm,'Consumibles de ejemplo.','inv_misc_bandage_15',@gid_cons,0
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Pack - Vendas (x3)' AND `realm`=@realm);

INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`)
SELECT '32006','1','[Ejemplo] Frasco - Poder',2,10,0,@realm,'Consumible de ejemplo.','inv_potion_118',@gid_cons,0
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Frasco - Poder' AND `realm`=@realm);

INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`)
SELECT '32007','1','[Ejemplo] Piedra - Viaje',2,10,0,@realm,'Consumible de ejemplo.','inv_misc_rune_01',@gid_cons,0
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Piedra - Viaje' AND `realm`=@realm);

-- Servicios (sin ejecutar nada real; solo para mostrar variedad)
INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`,`command`,`command_need_character`)
SELECT NULL,NULL,'[Ejemplo] Servicio - Cambio de nombre',4,20,0,@realm,'Servicio de ejemplo (requiere configurar el comando real).','inv_scroll_06',@gid_serv,0,'.character rename',1
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Servicio - Cambio de nombre' AND `realm`=@realm);

INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`,`command`,`command_need_character`)
SELECT NULL,NULL,'[Ejemplo] Servicio - Cambio de raza',4,30,0,@realm,'Servicio de ejemplo (placeholder).','inv_scroll_05',@gid_serv,0,'.character changerace',1
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Servicio - Cambio de raza' AND `realm`=@realm);

INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`,`command`,`command_need_character`)
SELECT NULL,NULL,'[Ejemplo] Servicio - Cambio de facción',4,35,0,@realm,'Servicio de ejemplo (placeholder).','inv_scroll_11',@gid_serv,0,'.character changefaction',1
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Servicio - Cambio de facción' AND `realm`=@realm);

INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`,`command`,`command_need_character`)
SELECT NULL,NULL,'[Ejemplo] Servicio - Boost de profesión',3,25,0,@realm,'Servicio de ejemplo (placeholder).','trade_blacksmithing',@gid_serv,0,'.profession boost',1
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Servicio - Boost de profesión' AND `realm`=@realm);

INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`,`command`,`command_need_character`)
SELECT NULL,NULL,'[Ejemplo] Servicio - Reputación',3,20,0,@realm,'Servicio de ejemplo (placeholder).','inv_misc_tournaments_symbol_nightelf',@gid_serv,0,'.reputation add',1
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Servicio - Reputación' AND `realm`=@realm);

INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`,`command`,`command_need_character`)
SELECT NULL,NULL,'[Ejemplo] Servicio - Cambio de apariencia',3,15,0,@realm,'Servicio de ejemplo (placeholder).','inv_misc_ticket_tarot_deck',@gid_serv,0,'.character customize',1
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Servicio - Cambio de apariencia' AND `realm`=@realm);

INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`,`command`,`command_need_character`)
SELECT NULL,NULL,'[Ejemplo] Servicio - Teleport a ciudad',2,5,0,@realm,'Servicio de ejemplo (placeholder).','spell_arcane_teleportstormwind',@gid_serv,0,'.tele stormwind',1
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Servicio - Teleport a ciudad' AND `realm`=@realm);

INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`,`command`,`command_need_character`)
SELECT NULL,NULL,'[Ejemplo] Servicio - Reset talentos',2,5,0,@realm,'Servicio de ejemplo (placeholder).','spell_nature_reincarnation',@gid_serv,0,'.reset talents',1
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Servicio - Reset talentos' AND `realm`=@realm);

-- Paquetes
INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`)
SELECT '33000','1','[Ejemplo] Pack - Starter',2,15,0,@realm,'Pack de ejemplo para poblar la tienda.','inv_misc_bag_10',@gid_bundles,0
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Pack - Starter' AND `realm`=@realm);

INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`)
SELECT '33001','1','[Ejemplo] Pack - Aventurero',3,25,0,@realm,'Pack de ejemplo.','inv_misc_bag_09',@gid_bundles,0
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Pack - Aventurero' AND `realm`=@realm);

INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`)
SELECT '33002','1','[Ejemplo] Pack - Epico',4,45,0,@realm,'Pack de ejemplo.','inv_misc_bag_20',@gid_bundles,0
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Pack - Epico' AND `realm`=@realm);

INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`)
SELECT '33003','1','[Ejemplo] Pack - Legendario',5,70,0,@realm,'Pack de ejemplo.','inv_misc_bag_19',@gid_bundles,0
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Pack - Legendario' AND `realm`=@realm);

INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`)
SELECT '33004','1','[Ejemplo] Pack - Coleccionista',4,60,0,@realm,'Pack de ejemplo.','inv_misc_bag_enchantedrunecloth',@gid_bundles,0
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Pack - Coleccionista' AND `realm`=@realm);

INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`)
SELECT '33005','1','[Ejemplo] Pack - Montura + Mascota',4,65,0,@realm,'Pack de ejemplo.','inv_misc_bag_07',@gid_bundles,0
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Pack - Montura + Mascota' AND `realm`=@realm);

INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`)
SELECT '33006','1','[Ejemplo] Pack - PvP',3,35,0,@realm,'Pack de ejemplo.','inv_sword_27',@gid_bundles,0
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Pack - PvP' AND `realm`=@realm);

INSERT INTO `store_items` (`itemid`,`itemcount`,`name`,`quality`,`vp_price`,`dp_price`,`realm`,`description`,`icon`,`group`,`tooltip`)
SELECT '33007','1','[Ejemplo] Pack - PvE',3,35,0,@realm,'Pack de ejemplo.','inv_helmet_21',@gid_bundles,0
WHERE NOT EXISTS (SELECT 1 FROM `store_items` WHERE `name`='[Ejemplo] Pack - PvE' AND `realm`=@realm);
