
//Dispite calling itself a sniper rifle, this is more balanced as if it was a mid-range precision weapon akin to the dmr.
/obj/item/weapon/gun/energy/SDSR_10
	name = "SDSR-10"
	desc = "The Sonic Dispersion Sniper Rifle is a supposed prototype of an ONI Hard Sound Rifle. This prototype has a greatly decreased effectiveness compared to the final product. Construction blueprints were recovered from an ONI prowler. 10 seconds recharge time."
	icon = 'code/modules/halo/weapons/icons/Weapon Sprites.dmi'
	icon_state = "SoundRifle-full"
	item_state = "w_stungun"
	fire_sound = 'code/modules/halo/sounds/sound_rifle_firesound.ogg'
	charge_meter = 0
	self_recharge = 1
	recharge_time = 10
	max_shots = 1
	dispersion = list(0)
	one_hand_penalty = -1
	screen_shake = 0
	//I would use the DMR's acc/scopedacc setup here but this is a one-shot gun.
	accuracy = 2
	scoped_accuracy = 4
	scope_zoom_amount = 3
	is_scope_variable = 1
	projectile_type = /obj/item/projectile/SDSS_proj
	item_icons = list(
		slot_l_hand_str = 'code/modules/halo/weapons/icons/Weapon_Inhands_left.dmi',
		slot_r_hand_str = 'code/modules/halo/weapons/icons/Weapon_Inhands_right.dmi',
		)

//SDSS PROJECTILE
/obj/item/projectile/SDSS_proj
	name = "hard sound wave"
	desc = "It's a wave of sound that's also suprisingly dense."
	step_delay = 0.1
	icon = null //No icon on purpose, it's a sound wave.
	icon_state = ""
	damtype = PAIN
	damage = 40
	//NOTE: Life() calls happen every two seconds, and life() reduces dizziness by one
	var/stun_time = 3 //This is in ticks
	var/suppress_intensity = 7
	var/disorient_time = 8

/obj/item/projectile/SDSS_proj/on_hit(var/mob/living/carbon/human/L, var/blocked = 0, var/def_zone = null)
	. = ..()
	if(!istype(L) || !isliving(L) || isanimal(L))
		return 0

	L.Weaken(stun_time)
	L.confused += disorient_time
	shake_camera(L,disorient_time,2)
	L.overlay_fullscreen("suppress",/obj/screen/fullscreen/oxy, suppress_intensity)
	return 1
