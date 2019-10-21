package;


import haxe.io.Bytes;
import lime.utils.AssetBundle;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {


	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;


	public static function init (config:Dynamic):Void {

		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();

		rootPath = null;

		if (config != null && Reflect.hasField (config, "rootPath")) {

			rootPath = Reflect.field (config, "rootPath");

		}

		if (rootPath == null) {

			#if (ios || tvos || emscripten)
			rootPath = "assets/";
			#elseif android
			rootPath = "";
			#elseif console
			rootPath = lime.system.System.applicationDirectory;
			#else
			rootPath = "./";
			#end

		}

		Assets.defaultRootPath = rootPath;

		#if (openfl && !flash && !display)
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_monsterrat_ttf);
		
		#end

		var data, manifest, library, bundle;

		#if kha

		null
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("null", library);

		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("null");

		#else

		data = '{"name":null,"assets":"aoy4:pathy28:assets%2Fdata%2Froom-001.oely4:sizei6837y4:typey4:TEXTy2:idR1y7:preloadtgoR0y28:assets%2Fdata%2Froom-002.oelR2i24376R3R4R5R7R6tgoR0y28:assets%2Fdata%2Froom-003.oelR2i20086R3R4R5R8R6tgoR0y34:assets%2Fdata%2Fdata-goes-here.txtR2zR3R4R5R9R6tgoR0y23:assets%2Fdata%2FRUP.oepR2i7576R3R4R5R10R6tgoR2i4567166R3y5:MUSICR5y27:assets%2Fmusic%2Fwarped.mp3y9:pathGroupaR12y27:assets%2Fmusic%2Fwarped.ogghR6tgoR2i1583496R3R11R5R14R13aR12R14hgoR0y36:assets%2Fmusic%2Fmusic-goes-here.txtR2zR3R4R5R15R6tgoR2i1381985R3R11R5y26:assets%2Fmusic%2Fflags.oggR13aR16y26:assets%2Fmusic%2Fflags.mp3hR6tgoR2i3949631R3R11R5R17R13aR16R17hgoR2i174124R3y5:SOUNDR5y27:assets%2Fsounds%2Fjump1.wavR13aR19hR6tgoR2i116132R3R18R5y26:assets%2Fsounds%2Fcoin.wavR13aR20hR6tgoR2i148996R3R18R5y27:assets%2Fsounds%2Fslash.wavR13aR21hR6tgoR2i19278R3R18R5y26:assets%2Fsounds%2Fjump.wavR13aR22hR6tgoR0y36:assets%2Fsounds%2Fsounds-go-here.txtR2zR3R4R5R23R6tgoR2i46542R3R18R5y25:assets%2Fsounds%2Fbox.wavR13aR24hR6tgoR2i118060R3R18R5y37:assets%2Fsounds%2Fjump%20original.wavR13aR25hR6tgoR2i352844R3R18R5y27:assets%2Fsounds%2Fwater.wavR13aR26hR6tgoR2i88298R3R18R5y34:assets%2Fsounds%2Fskull_damage.wavR13aR27hR6tgoR2i65536R3R18R5y28:assets%2Fsounds%2Fdamage.wavR13aR28hR6tgoR0y36:assets%2Fimages%2FskeletonSprite.pngR2i1341R3y5:IMAGER5R29R6tgoR0y42:assets%2Fimages%2Fsheet_hero_idle28x30.pngR2i5457R3R30R5R31R6tgoR0y29:assets%2Fimages%2Fescada2.pngR2i633R3R30R5R32R6tgoR0y29:assets%2Fimages%2Fescada0.pngR2i651R3R30R5R33R6tgoR0y39:assets%2Fimages%2ForcMasked-w13-h18.pngR2i1164R3R30R5R34R6tgoR0y26:assets%2Fimages%2Fcoin.pngR2i17827R3R30R5R35R6tgoR0y31:assets%2Fimages%2Fnextlevel.pngR2i663R3R30R5R36R6tgoR0y27:assets%2Fimages%2Ftiles.pngR2i19425R3R30R5R37R6tgoR0y32:assets%2Fimages%2Fbackground.pngR2i158R3R30R5R38R6tgoR0y27:assets%2Fimages%2Fwater.pngR2i715R3R30R5R39R6tgoR0y27:assets%2Fimages%2Frock1.pngR2i746R3R30R5R40R6tgoR0y29:assets%2Fimages%2Fescada1.pngR2i632R3R30R5R41R6tgoR0y32:assets%2Fimages%2Fskull12x14.pngR2i799R3R30R5R42R6tgoR0y27:assets%2Fimages%2Fgnome.pngR2i3520R3R30R5R43R6tgoR0y34:assets%2Fimages%2FlifeBar41x12.pngR2i878R3R30R5R44R6tgoR0y28:assets%2Fimages%2Fgnome1.pngR2i14890R3R30R5R45R6tgoR0y26:assets%2Fimages%2Frock.pngR2i720R3R30R5R46R6tgoR0y30:assets%2Fimages%2Fskeleton.pngR2i319R3R30R5R47R6tgoR0y30:assets%2Fimages%2Fbox12x12.pngR2i666R3R30R5R48R6tgoR0y32:assets%2Fimages%2Fcoin-w6-h7.pngR2i657R3R30R5R49R6tgoR0y32:assets%2Fimages%2Fcharacters.pngR2i12754R3R30R5R50R6tgoR0y25:assets%2Fimages%2Fbox.pngR2i685R3R30R5R51R6tgoR2i39706R3R11R5y28:flixel%2Fsounds%2Fflixel.mp3R13aR52y28:flixel%2Fsounds%2Fflixel.ogghR6tgoR2i2114R3R11R5y26:flixel%2Fsounds%2Fbeep.mp3R13aR54y26:flixel%2Fsounds%2Fbeep.ogghR6tgoR2i5794R3R18R5R55R13aR54R55hgoR2i33629R3R18R5R53R13aR52R53hgoR2i15744R3y4:FONTy9:classNamey35:__ASSET__flixel_fonts_nokiafc22_ttfR5y30:flixel%2Ffonts%2Fnokiafc22.ttfR6tgoR2i29724R3R56R57y36:__ASSET__flixel_fonts_monsterrat_ttfR5y31:flixel%2Ffonts%2Fmonsterrat.ttfR6tgoR0y33:flixel%2Fimages%2Fui%2Fbutton.pngR2i519R3R30R5R62R6tgoR0y36:flixel%2Fimages%2Flogo%2Fdefault.pngR2i3280R3R30R5R63R6tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		

		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		

		#end

	}


}


#if kha

null

#else

#if !display
#if flash

@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_room_001_oel extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_room_002_oel extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_room_003_oel extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_data_goes_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_rup_oep extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_warped_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_warped_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_music_goes_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_flags_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_flags_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_jump1_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_coin_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_slash_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_jump_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_box_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_jump_original_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_water_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_skull_damage_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_damage_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_skeletonsprite_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_sheet_hero_idle28x30_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_escada2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_escada0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_orcmasked_w13_h18_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_coin_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_nextlevel_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_tiles_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_background_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_water_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_rock1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_escada1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_skull12x14_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_gnome_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_lifebar41x12_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_gnome1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_rock_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_skeleton_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_box12x12_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_coin_w6_h7_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_characters_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_box_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:keep @:file("assets/data/room-001.oel") @:noCompletion #if display private #end class __ASSET__assets_data_room_001_oel extends haxe.io.Bytes {}
@:keep @:file("assets/data/room-002.oel") @:noCompletion #if display private #end class __ASSET__assets_data_room_002_oel extends haxe.io.Bytes {}
@:keep @:file("assets/data/room-003.oel") @:noCompletion #if display private #end class __ASSET__assets_data_room_003_oel extends haxe.io.Bytes {}
@:keep @:file("assets/data/data-goes-here.txt") @:noCompletion #if display private #end class __ASSET__assets_data_data_goes_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/RUP.oep") @:noCompletion #if display private #end class __ASSET__assets_data_rup_oep extends haxe.io.Bytes {}
@:keep @:file("assets/music/warped.mp3") @:noCompletion #if display private #end class __ASSET__assets_music_warped_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/music/warped.ogg") @:noCompletion #if display private #end class __ASSET__assets_music_warped_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/music/music-goes-here.txt") @:noCompletion #if display private #end class __ASSET__assets_music_music_goes_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/music/flags.ogg") @:noCompletion #if display private #end class __ASSET__assets_music_flags_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/music/flags.mp3") @:noCompletion #if display private #end class __ASSET__assets_music_flags_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/jump1.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_jump1_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/coin.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_coin_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/slash.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_slash_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/jump.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_jump_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/sounds-go-here.txt") @:noCompletion #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/box.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_box_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/jump original.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_jump_original_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/water.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_water_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/skull_damage.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_skull_damage_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/damage.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_damage_wav extends haxe.io.Bytes {}
@:keep @:image("assets/images/skeletonSprite.png") @:noCompletion #if display private #end class __ASSET__assets_images_skeletonsprite_png extends lime.graphics.Image {}
@:keep @:image("assets/images/sheet_hero_idle28x30.png") @:noCompletion #if display private #end class __ASSET__assets_images_sheet_hero_idle28x30_png extends lime.graphics.Image {}
@:keep @:image("assets/images/escada2.png") @:noCompletion #if display private #end class __ASSET__assets_images_escada2_png extends lime.graphics.Image {}
@:keep @:image("assets/images/escada0.png") @:noCompletion #if display private #end class __ASSET__assets_images_escada0_png extends lime.graphics.Image {}
@:keep @:image("assets/images/orcMasked-w13-h18.png") @:noCompletion #if display private #end class __ASSET__assets_images_orcmasked_w13_h18_png extends lime.graphics.Image {}
@:keep @:image("assets/images/coin.png") @:noCompletion #if display private #end class __ASSET__assets_images_coin_png extends lime.graphics.Image {}
@:keep @:image("assets/images/nextlevel.png") @:noCompletion #if display private #end class __ASSET__assets_images_nextlevel_png extends lime.graphics.Image {}
@:keep @:image("assets/images/tiles.png") @:noCompletion #if display private #end class __ASSET__assets_images_tiles_png extends lime.graphics.Image {}
@:keep @:image("assets/images/background.png") @:noCompletion #if display private #end class __ASSET__assets_images_background_png extends lime.graphics.Image {}
@:keep @:image("assets/images/water.png") @:noCompletion #if display private #end class __ASSET__assets_images_water_png extends lime.graphics.Image {}
@:keep @:image("assets/images/rock1.png") @:noCompletion #if display private #end class __ASSET__assets_images_rock1_png extends lime.graphics.Image {}
@:keep @:image("assets/images/escada1.png") @:noCompletion #if display private #end class __ASSET__assets_images_escada1_png extends lime.graphics.Image {}
@:keep @:image("assets/images/skull12x14.png") @:noCompletion #if display private #end class __ASSET__assets_images_skull12x14_png extends lime.graphics.Image {}
@:keep @:image("assets/images/gnome.png") @:noCompletion #if display private #end class __ASSET__assets_images_gnome_png extends lime.graphics.Image {}
@:keep @:image("assets/images/lifeBar41x12.png") @:noCompletion #if display private #end class __ASSET__assets_images_lifebar41x12_png extends lime.graphics.Image {}
@:keep @:image("assets/images/gnome1.png") @:noCompletion #if display private #end class __ASSET__assets_images_gnome1_png extends lime.graphics.Image {}
@:keep @:image("assets/images/rock.png") @:noCompletion #if display private #end class __ASSET__assets_images_rock_png extends lime.graphics.Image {}
@:keep @:image("assets/images/skeleton.png") @:noCompletion #if display private #end class __ASSET__assets_images_skeleton_png extends lime.graphics.Image {}
@:keep @:image("assets/images/box12x12.png") @:noCompletion #if display private #end class __ASSET__assets_images_box12x12_png extends lime.graphics.Image {}
@:keep @:image("assets/images/coin-w6-h7.png") @:noCompletion #if display private #end class __ASSET__assets_images_coin_w6_h7_png extends lime.graphics.Image {}
@:keep @:image("assets/images/characters.png") @:noCompletion #if display private #end class __ASSET__assets_images_characters_png extends lime.graphics.Image {}
@:keep @:image("assets/images/box.png") @:noCompletion #if display private #end class __ASSET__assets_images_box_png extends lime.graphics.Image {}
@:keep @:file("/usr/share/haxe/lib/flixel/4,6,3/assets/sounds/flixel.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends haxe.io.Bytes {}
@:keep @:file("/usr/share/haxe/lib/flixel/4,6,3/assets/sounds/beep.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends haxe.io.Bytes {}
@:keep @:file("/usr/share/haxe/lib/flixel/4,6,3/assets/sounds/beep.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends haxe.io.Bytes {}
@:keep @:file("/usr/share/haxe/lib/flixel/4,6,3/assets/sounds/flixel.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends haxe.io.Bytes {}
@:keep @:font("export/html5/obj/webfont/nokiafc22.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/monsterrat.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font {}
@:keep @:image("/usr/share/haxe/lib/flixel/4,6,3/assets/images/ui/button.png") @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends lime.graphics.Image {}
@:keep @:image("/usr/share/haxe/lib/flixel/4,6,3/assets/images/logo/default.png") @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends lime.graphics.Image {}
@:keep @:file("") @:noCompletion #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else

@:keep @:expose('__ASSET__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/nokiafc22"; #else ascender = 2048; descender = -512; height = 2816; numGlyphs = 172; underlinePosition = -640; underlineThickness = 256; unitsPerEM = 2048; #end name = "Nokia Cellphone FC Small"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/monsterrat"; #else ascender = 968; descender = -251; height = 1219; numGlyphs = 263; underlinePosition = -150; underlineThickness = 50; unitsPerEM = 1000; #end name = "Monsterrat"; super (); }}


#end

#if (openfl && !flash)

#if html5
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#else
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#end

#end
#end

#end
