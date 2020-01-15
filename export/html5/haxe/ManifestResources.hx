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

		data = '{"name":null,"assets":"aoy4:pathy36:assets%2Fsounds%2Fsounds-go-here.txty4:sizezy4:typey4:TEXTy2:idR1y7:preloadtgoR2i19278R3y5:SOUNDR5y26:assets%2Fsounds%2Fjump.wavy9:pathGroupaR8hR6tgoR2i174124R3R7R5y27:assets%2Fsounds%2Fjump1.wavR9aR10hR6tgoR2i148996R3R7R5y27:assets%2Fsounds%2Fslash.wavR9aR11hR6tgoR2i46542R3R7R5y25:assets%2Fsounds%2Fbox.wavR9aR12hR6tgoR2i118060R3R7R5y37:assets%2Fsounds%2Fjump%20original.wavR9aR13hR6tgoR2i352844R3R7R5y27:assets%2Fsounds%2Fwater.wavR9aR14hR6tgoR2i65536R3R7R5y28:assets%2Fsounds%2Fdamage.wavR9aR15hR6tgoR2i116132R3R7R5y26:assets%2Fsounds%2Fcoin.wavR9aR16hR6tgoR2i88298R3R7R5y34:assets%2Fsounds%2Fskull_damage.wavR9aR17hR6tgoR0y23:assets%2Fdata%2FRUP.oepR2i7576R3R4R5R18R6tgoR0y28:assets%2Fdata%2Froom-002.oelR2i24376R3R4R5R19R6tgoR0y28:assets%2Fdata%2Froom-003.oelR2i20086R3R4R5R20R6tgoR0y34:assets%2Fdata%2Fdata-goes-here.txtR2zR3R4R5R21R6tgoR0y28:assets%2Fdata%2Froom-001.oelR2i6837R3R4R5R22R6tgoR0y26:assets%2Fimages%2Frock.pngR2i720R3y5:IMAGER5R23R6tgoR0y27:assets%2Fimages%2Fwater.pngR2i715R3R24R5R25R6tgoR0y25:assets%2Fimages%2Fbox.pngR2i685R3R24R5R26R6tgoR0y29:assets%2Fimages%2Fescada2.pngR2i633R3R24R5R27R6tgoR0y39:assets%2Fimages%2ForcMasked-w13-h18.pngR2i1164R3R24R5R28R6tgoR0y28:assets%2Fimages%2Fgnome1.pngR2i14890R3R24R5R29R6tgoR0y30:assets%2Fimages%2Fskeleton.pngR2i319R3R24R5R30R6tgoR0y30:assets%2Fimages%2Fbox12x12.pngR2i666R3R24R5R31R6tgoR0y27:assets%2Fimages%2Frock1.pngR2i746R3R24R5R32R6tgoR0y34:assets%2Fimages%2FlifeBar41x12.pngR2i878R3R24R5R33R6tgoR0y27:assets%2Fimages%2Fgnome.pngR2i3520R3R24R5R34R6tgoR0y29:assets%2Fimages%2Fescada1.pngR2i632R3R24R5R35R6tgoR0y32:assets%2Fimages%2Fbackground.pngR2i158R3R24R5R36R6tgoR0y32:assets%2Fimages%2Fcharacters.pngR2i12754R3R24R5R37R6tgoR0y43:assets%2Fimages%2Fsheet_hero_gray_28x30.pngR2i8624R3R24R5R38R6tgoR0y32:assets%2Fimages%2Fskull12x14.pngR2i799R3R24R5R39R6tgoR0y31:assets%2Fimages%2Fnextlevel.pngR2i663R3R24R5R40R6tgoR0y36:assets%2Fimages%2FskeletonSprite.pngR2i1341R3R24R5R41R6tgoR0y32:assets%2Fimages%2Fcoin-w6-h7.pngR2i657R3R24R5R42R6tgoR0y29:assets%2Fimages%2Fescada0.pngR2i651R3R24R5R43R6tgoR0y27:assets%2Fimages%2Ftiles.pngR2i19425R3R24R5R44R6tgoR0y26:assets%2Fimages%2Fcoin.pngR2i17827R3R24R5R45R6tgoR0y42:assets%2Fimages%2Fsheet_hero_idle28x30.pngR2i9372R3R24R5R46R6tgoR2i1583496R3y5:MUSICR5y27:assets%2Fmusic%2Fwarped.oggR9aR48y27:assets%2Fmusic%2Fwarped.mp3hR6tgoR2i4567166R3R47R5R49R9aR48R49hgoR0y36:assets%2Fmusic%2Fmusic-goes-here.txtR2zR3R4R5R50R6tgoR2i3949631R3R47R5y26:assets%2Fmusic%2Fflags.mp3R9aR51y26:assets%2Fmusic%2Fflags.ogghR6tgoR2i1381985R3R47R5R52R9aR51R52hgoR2i2114R3R47R5y26:flixel%2Fsounds%2Fbeep.mp3R9aR53y26:flixel%2Fsounds%2Fbeep.ogghR6tgoR2i39706R3R47R5y28:flixel%2Fsounds%2Fflixel.mp3R9aR55y28:flixel%2Fsounds%2Fflixel.ogghR6tgoR2i5794R3R7R5R54R9aR53R54hgoR2i33629R3R7R5R56R9aR55R56hgoR2i15744R3y4:FONTy9:classNamey35:__ASSET__flixel_fonts_nokiafc22_ttfR5y30:flixel%2Ffonts%2Fnokiafc22.ttfR6tgoR2i29724R3R57R58y36:__ASSET__flixel_fonts_monsterrat_ttfR5y31:flixel%2Ffonts%2Fmonsterrat.ttfR6tgoR0y33:flixel%2Fimages%2Fui%2Fbutton.pngR2i519R3R24R5R63R6tgoR0y36:flixel%2Fimages%2Flogo%2Fdefault.pngR2i3280R3R24R5R64R6tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
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

@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_jump_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_jump1_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_slash_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_box_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_jump_original_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_water_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_damage_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_coin_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_skull_damage_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_rup_oep extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_room_002_oel extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_room_003_oel extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_data_goes_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_room_001_oel extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_rock_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_water_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_box_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_escada2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_orcmasked_w13_h18_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_gnome1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_skeleton_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_box12x12_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_rock1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_lifebar41x12_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_gnome_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_escada1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_background_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_characters_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_sheet_hero_gray_28x30_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_skull12x14_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_nextlevel_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_skeletonsprite_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_coin_w6_h7_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_escada0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_tiles_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_coin_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_sheet_hero_idle28x30_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_warped_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_warped_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_music_goes_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_flags_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_flags_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:keep @:file("assets/sounds/sounds-go-here.txt") @:noCompletion #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/jump.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_jump_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/jump1.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_jump1_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/slash.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_slash_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/box.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_box_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/jump original.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_jump_original_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/water.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_water_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/damage.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_damage_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/coin.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_coin_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/skull_damage.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_skull_damage_wav extends haxe.io.Bytes {}
@:keep @:file("assets/data/RUP.oep") @:noCompletion #if display private #end class __ASSET__assets_data_rup_oep extends haxe.io.Bytes {}
@:keep @:file("assets/data/room-002.oel") @:noCompletion #if display private #end class __ASSET__assets_data_room_002_oel extends haxe.io.Bytes {}
@:keep @:file("assets/data/room-003.oel") @:noCompletion #if display private #end class __ASSET__assets_data_room_003_oel extends haxe.io.Bytes {}
@:keep @:file("assets/data/data-goes-here.txt") @:noCompletion #if display private #end class __ASSET__assets_data_data_goes_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/room-001.oel") @:noCompletion #if display private #end class __ASSET__assets_data_room_001_oel extends haxe.io.Bytes {}
@:keep @:image("assets/images/rock.png") @:noCompletion #if display private #end class __ASSET__assets_images_rock_png extends lime.graphics.Image {}
@:keep @:image("assets/images/water.png") @:noCompletion #if display private #end class __ASSET__assets_images_water_png extends lime.graphics.Image {}
@:keep @:image("assets/images/box.png") @:noCompletion #if display private #end class __ASSET__assets_images_box_png extends lime.graphics.Image {}
@:keep @:image("assets/images/escada2.png") @:noCompletion #if display private #end class __ASSET__assets_images_escada2_png extends lime.graphics.Image {}
@:keep @:image("assets/images/orcMasked-w13-h18.png") @:noCompletion #if display private #end class __ASSET__assets_images_orcmasked_w13_h18_png extends lime.graphics.Image {}
@:keep @:image("assets/images/gnome1.png") @:noCompletion #if display private #end class __ASSET__assets_images_gnome1_png extends lime.graphics.Image {}
@:keep @:image("assets/images/skeleton.png") @:noCompletion #if display private #end class __ASSET__assets_images_skeleton_png extends lime.graphics.Image {}
@:keep @:image("assets/images/box12x12.png") @:noCompletion #if display private #end class __ASSET__assets_images_box12x12_png extends lime.graphics.Image {}
@:keep @:image("assets/images/rock1.png") @:noCompletion #if display private #end class __ASSET__assets_images_rock1_png extends lime.graphics.Image {}
@:keep @:image("assets/images/lifeBar41x12.png") @:noCompletion #if display private #end class __ASSET__assets_images_lifebar41x12_png extends lime.graphics.Image {}
@:keep @:image("assets/images/gnome.png") @:noCompletion #if display private #end class __ASSET__assets_images_gnome_png extends lime.graphics.Image {}
@:keep @:image("assets/images/escada1.png") @:noCompletion #if display private #end class __ASSET__assets_images_escada1_png extends lime.graphics.Image {}
@:keep @:image("assets/images/background.png") @:noCompletion #if display private #end class __ASSET__assets_images_background_png extends lime.graphics.Image {}
@:keep @:image("assets/images/characters.png") @:noCompletion #if display private #end class __ASSET__assets_images_characters_png extends lime.graphics.Image {}
@:keep @:image("assets/images/sheet_hero_gray_28x30.png") @:noCompletion #if display private #end class __ASSET__assets_images_sheet_hero_gray_28x30_png extends lime.graphics.Image {}
@:keep @:image("assets/images/skull12x14.png") @:noCompletion #if display private #end class __ASSET__assets_images_skull12x14_png extends lime.graphics.Image {}
@:keep @:image("assets/images/nextlevel.png") @:noCompletion #if display private #end class __ASSET__assets_images_nextlevel_png extends lime.graphics.Image {}
@:keep @:image("assets/images/skeletonSprite.png") @:noCompletion #if display private #end class __ASSET__assets_images_skeletonsprite_png extends lime.graphics.Image {}
@:keep @:image("assets/images/coin-w6-h7.png") @:noCompletion #if display private #end class __ASSET__assets_images_coin_w6_h7_png extends lime.graphics.Image {}
@:keep @:image("assets/images/escada0.png") @:noCompletion #if display private #end class __ASSET__assets_images_escada0_png extends lime.graphics.Image {}
@:keep @:image("assets/images/tiles.png") @:noCompletion #if display private #end class __ASSET__assets_images_tiles_png extends lime.graphics.Image {}
@:keep @:image("assets/images/coin.png") @:noCompletion #if display private #end class __ASSET__assets_images_coin_png extends lime.graphics.Image {}
@:keep @:image("assets/images/sheet_hero_idle28x30.png") @:noCompletion #if display private #end class __ASSET__assets_images_sheet_hero_idle28x30_png extends lime.graphics.Image {}
@:keep @:file("assets/music/warped.ogg") @:noCompletion #if display private #end class __ASSET__assets_music_warped_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/music/warped.mp3") @:noCompletion #if display private #end class __ASSET__assets_music_warped_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/music/music-goes-here.txt") @:noCompletion #if display private #end class __ASSET__assets_music_music_goes_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/music/flags.mp3") @:noCompletion #if display private #end class __ASSET__assets_music_flags_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/music/flags.ogg") @:noCompletion #if display private #end class __ASSET__assets_music_flags_ogg extends haxe.io.Bytes {}
@:keep @:file("/home/gui/haxelib/flixel/4,6,3/assets/sounds/beep.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends haxe.io.Bytes {}
@:keep @:file("/home/gui/haxelib/flixel/4,6,3/assets/sounds/flixel.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends haxe.io.Bytes {}
@:keep @:file("/home/gui/haxelib/flixel/4,6,3/assets/sounds/beep.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends haxe.io.Bytes {}
@:keep @:file("/home/gui/haxelib/flixel/4,6,3/assets/sounds/flixel.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends haxe.io.Bytes {}
@:keep @:font("export/html5/obj/webfont/nokiafc22.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/monsterrat.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font {}
@:keep @:image("/home/gui/haxelib/flixel/4,6,3/assets/images/ui/button.png") @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends lime.graphics.Image {}
@:keep @:image("/home/gui/haxelib/flixel/4,6,3/assets/images/logo/default.png") @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends lime.graphics.Image {}
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
