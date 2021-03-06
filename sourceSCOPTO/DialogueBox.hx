package;

import flixel.system.FlxSound;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;
	var portraitShpee:FlxSprite;
	var portraitClone:FlxSprite;
	var portraitShpeeTired:FlxSprite;
	var portraitAlifeTone:FlxSprite;
	var portraitAlifeAkward:FlxSprite;
	var portraitShpeeAkward:FlxSprite;
	var portraitShpeeHappy:FlxSprite;
	var portraitShpeeNervous:FlxSprite;
	var portraitAlife:FlxSprite;
	//ALIFE DUPE CUS IM STUPID AND CANT FIX THIS

	var wtf:FlxSound;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'bloxiam':
				FlxG.sound.playMusic(Paths.music('ScoptoDialogue'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'gloomy-streets':
				FlxG.sound.playMusic(Paths.music('ScoptoDialogue'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'taking-matters':
				FlxG.sound.playMusic(Paths.music('ScoptoDialogue'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'the-clone':
				FlxG.sound.playMusic(Paths.music('cloneDialogue'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);	
			
		}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 45);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);
				
			case 'bloxiam':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.width = 220;
				box.height = 220;
				box.x = -100;
				box.y = 400;
			
			case 'gloomy-streets':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.width = 220;
				box.height = 220;
				box.x = -100;
				box.y = 400;
			
			case 'taking-matters':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
			    box.width = 220;
				box.height = 220;
				box.x = -100;
				box.y = 400;
				
			case 'the-clone':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.width = 220;
				box.height = 220;
				box.x = -100;
				box.y = 400;
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;
	if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'roses' || PlayState.SONG.song.toLowerCase() == 'thorns')
	{
		portraitLeft = new FlxSprite(-20, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
		portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;
    }
		if (PlayState.SONG.song.toLowerCase() == 'bloxiam')
	{
		portraitLeft = new FlxSprite(-20, 30);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
		portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;
    }
	if (PlayState.SONG.song.toLowerCase() == 'gloomy-streets')
	{
		portraitLeft = new FlxSprite(750, 110);
		portraitLeft.frames = Paths.getSparrowAtlas('scopto/alife portraits');
		portraitLeft.animation.addByPrefix('enter', 'alife enter', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;
    }
	if (PlayState.SONG.song.toLowerCase() == 'taking-matters')
	{
		portraitLeft = new FlxSprite(750, 110);
		portraitLeft.frames = Paths.getSparrowAtlas('scopto/alife portraits');
		portraitLeft.animation.addByPrefix('enter', 'alife enter', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;
    }
	if (PlayState.SONG.song.toLowerCase() == 'the-clone')
	{
		portraitLeft = new FlxSprite(750, 110);
		portraitLeft.frames = Paths.getSparrowAtlas('scopto/alife portraits');
		portraitLeft.animation.addByPrefix('enter', 'alife enter', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;
    }
	if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'roses' || PlayState.SONG.song.toLowerCase() == 'thorns')
	{
		portraitRight = new FlxSprite(0, 40);
		portraitRight.frames = Paths.getSparrowAtlas('weeb/bfPortrait');
		portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;
	}
	if (PlayState.SONG.song.toLowerCase() == 'bloxiam')
	{
		portraitRight = new FlxSprite(0, 30);
		portraitRight.frames = Paths.getSparrowAtlas('weeb/bfPortrait');
		portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;
	}
	if (PlayState.SONG.song.toLowerCase() == 'gloomy-streets')
	{
		portraitRight = new FlxSprite(750, 180);
		portraitRight.frames = Paths.getSparrowAtlas('scopto/boyfriend portraits');
		portraitRight.animation.addByPrefix('enter', 'bf portrait enter', 24, false);
		portraitRight.animation.addByPrefix('enterhorrified', 'bf horrified enter', 24, false);
		portraitRight.animation.addByPrefix('enterkickasslol', 'bf kickass enter', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;
	}
	if (PlayState.SONG.song.toLowerCase() == 'taking-matters')
	{
		portraitRight = new FlxSprite(750, 180);
		portraitRight.frames = Paths.getSparrowAtlas('scopto/boyfriend portraits');
		portraitRight.animation.addByPrefix('enter', 'bf portrait enter', 24, false);
		portraitRight.animation.addByPrefix('enterhorrified', 'bf horrified enter', 24, false);
		portraitRight.animation.addByPrefix('enterkickasslol', 'bf kickass enter', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;
	}
	if (PlayState.SONG.song.toLowerCase() == 'the-clone')
	{
		portraitRight = new FlxSprite(750, 180);
		portraitRight.frames = Paths.getSparrowAtlas('scopto/boyfriend portraits');
		portraitRight.animation.addByPrefix('enter', 'bf portrait enter', 24, false);
		portraitRight.animation.addByPrefix('enterhorrified', 'bf horrified enter', 24, false);
		portraitRight.animation.addByPrefix('enterkickasslol', 'bf kickass enter', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;
	}
	if (PlayState.SONG.song.toLowerCase() == 'gloomy-streets')
	{
		portraitShpee = new FlxSprite(150, 86);
		portraitShpee.frames = Paths.getSparrowAtlas('scopto/shpee_portraits');
		portraitShpee.animation.addByPrefix('enter', 'Shpee enter', 24, false);
		portraitShpee.setGraphicSize(Std.int(portraitShpee.width * PlayState.daPixelZoom * 0));
		portraitShpee.updateHitbox();
		portraitShpee.scrollFactor.set();
		add(portraitShpee);
		portraitShpee.visible = false;
    }
	if (PlayState.SONG.song.toLowerCase() == 'taking-matters')
	{
		portraitShpee = new FlxSprite(150, 86);
		portraitShpee.frames = Paths.getSparrowAtlas('scopto/shpee_portraits');
		portraitShpee.animation.addByPrefix('enter', 'Shpee enter', 24, false);
		portraitShpee.setGraphicSize(Std.int(portraitShpee.width * PlayState.daPixelZoom * 0));
		portraitShpee.updateHitbox();
		portraitShpee.scrollFactor.set();
		add(portraitShpee);
		portraitShpee.visible = false;
    }
	if (PlayState.SONG.song.toLowerCase() == 'the-clone')
	{
		portraitShpee = new FlxSprite(150, 86);
		portraitShpee.frames = Paths.getSparrowAtlas('scopto/shpee_portraits');
		portraitShpee.animation.addByPrefix('enter', 'Shpee enter', 24, false);
		portraitShpee.setGraphicSize(Std.int(portraitShpee.width * PlayState.daPixelZoom * 0));
		portraitShpee.updateHitbox();
		portraitShpee.scrollFactor.set();
		add(portraitShpee);
		portraitShpee.visible = false;
    }
	if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'roses' || PlayState.SONG.song.toLowerCase() == 'thorns')
	{
		portraitLeft = new FlxSprite(-20, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
		portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;
	}
	if (PlayState.SONG.song.toLowerCase() == 'the-clone')
	{
		portraitClone = new FlxSprite(190, 86);
		portraitClone.frames = Paths.getSparrowAtlas('scopto/the clone enter');
		portraitClone.animation.addByPrefix('enter', 'the clone enter', 24, false);
		portraitClone.setGraphicSize(Std.int(portraitClone.width * PlayState.daPixelZoom * 0));
		portraitClone.updateHitbox();
		portraitClone.scrollFactor.set();
		add(portraitClone);
		portraitClone.visible = false;
	}
	if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'roses' || PlayState.SONG.song.toLowerCase() == 'thorns')
	{
		portraitLeft = new FlxSprite(-20, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
		portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;
	}
	if (PlayState.SONG.song.toLowerCase() == 'taking-matters')
	{
		portraitShpeeTired = new FlxSprite(150, 86);
		portraitShpeeTired.frames = Paths.getSparrowAtlas('scopto/shpee_portraits');
		portraitShpeeTired.animation.addByPrefix('enter', 'Shpee tired enter', 24, false);
		portraitShpeeTired.setGraphicSize(Std.int(portraitShpeeTired.width * PlayState.daPixelZoom * 0));
		portraitShpeeTired.updateHitbox();
		portraitShpeeTired.scrollFactor.set();
		add(portraitShpeeTired);
		portraitShpeeTired.visible = false;
	}
	if (PlayState.SONG.song.toLowerCase() == 'the-clone')
	{
		portraitShpeeTired = new FlxSprite(150, 86);
		portraitShpeeTired.frames = Paths.getSparrowAtlas('scopto/shpee_portraits');
		portraitShpeeTired.animation.addByPrefix('enter', 'Shpee tired enter', 24, false);
		portraitShpeeTired.setGraphicSize(Std.int(portraitShpeeTired.width * PlayState.daPixelZoom * 0));
		portraitShpeeTired.updateHitbox();
		portraitShpeeTired.scrollFactor.set();
		add(portraitShpeeTired);
		portraitShpeeTired.visible = false;
	}
	
	if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'roses' || PlayState.SONG.song.toLowerCase() == 'thorns')
	{
		portraitLeft = new FlxSprite(-20, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
		portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;
	}
	if (PlayState.SONG.song.toLowerCase() == 'taking-matters')
	{
		//bitch!
		portraitAlifeTone = new FlxSprite(150, 155);
		portraitAlifeTone.frames = Paths.getSparrowAtlas('scopto/alife portraits');
		portraitAlifeTone.animation.addByPrefix('enter', 'alife tone enter', 24, false);
		portraitAlifeTone.setGraphicSize(Std.int(portraitAlifeTone.width * PlayState.daPixelZoom * 0));
		portraitAlifeTone.updateHitbox();
		portraitAlifeTone.scrollFactor.set();
		add(portraitAlifeTone);
		portraitAlifeTone.visible = false;
	}
	if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'roses' || PlayState.SONG.song.toLowerCase() == 'thorns')
	{
		portraitLeft = new FlxSprite(-20, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
		portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;
	}
	if (PlayState.SONG.song.toLowerCase() == 'taking-matters')
	{
		portraitAlifeAkward = new FlxSprite(150, 155);
		portraitAlifeAkward.frames = Paths.getSparrowAtlas('scopto/alife portraits');
		portraitAlifeAkward.animation.addByPrefix('enter', 'alife akward enter', 24, false);
		portraitAlifeAkward.setGraphicSize(Std.int(portraitAlifeAkward.width * PlayState.daPixelZoom * 0));
		portraitAlifeAkward.updateHitbox();
		portraitAlifeAkward.scrollFactor.set();
		add(portraitAlifeAkward);
		portraitAlifeAkward.visible = false;
	}
	if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'roses' || PlayState.SONG.song.toLowerCase() == 'thorns')
	{
		portraitLeft = new FlxSprite(-20, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
		portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;
	}
	if (PlayState.SONG.song.toLowerCase() == 'taking-matters')
	{
		//boy what the hell boy
		portraitShpeeAkward = new FlxSprite(150, 86);
		portraitShpeeAkward.frames = Paths.getSparrowAtlas('scopto/shpee_portraits');
		portraitShpeeAkward.animation.addByPrefix('enter', 'Shpee akward enter', 24, false);
		portraitShpeeAkward.setGraphicSize(Std.int(portraitShpeeAkward.width * PlayState.daPixelZoom * 0));
		portraitShpeeAkward.updateHitbox();
		portraitShpeeAkward.scrollFactor.set();
		add(portraitShpeeAkward);
		portraitShpeeAkward.visible = false;
	}
	if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'roses' || PlayState.SONG.song.toLowerCase() == 'thorns')
	{
		portraitLeft = new FlxSprite(-20, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
		portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;
	}
	if (PlayState.SONG.song.toLowerCase() == 'gloomy-streets')
	{
		portraitShpeeHappy = new FlxSprite(150, 86);
		portraitShpeeHappy.frames = Paths.getSparrowAtlas('scopto/shpee_portraits');
		portraitShpeeHappy.animation.addByPrefix('enter', 'Shpee excited enter', 24, false);
		portraitShpeeHappy.setGraphicSize(Std.int(portraitShpeeHappy.width * PlayState.daPixelZoom * 0));
		portraitShpeeHappy.updateHitbox();
		portraitShpeeHappy.scrollFactor.set();
		add(portraitShpeeHappy);
		portraitShpeeHappy.visible = false;
	}
	if (PlayState.SONG.song.toLowerCase() == 'the-clone')
	{
		portraitShpeeHappy = new FlxSprite(150, 86);
		portraitShpeeHappy.frames = Paths.getSparrowAtlas('scopto/shpee_portraits');
		portraitShpeeHappy.animation.addByPrefix('enter', 'Shpee excited enter', 24, false);
		portraitShpeeHappy.setGraphicSize(Std.int(portraitShpeeHappy.width * PlayState.daPixelZoom * 0));
		portraitShpeeHappy.updateHitbox();
		portraitShpeeHappy.scrollFactor.set();
		add(portraitShpeeHappy);
		portraitShpeeHappy.visible = false;
	}
	if (PlayState.SONG.song.toLowerCase() == 'taking-matters')
	{
		portraitShpeeTired = new FlxSprite(150, 86);
		portraitShpeeTired.frames = Paths.getSparrowAtlas('scopto/shpee_portraits');
		portraitShpeeTired.animation.addByPrefix('enter', 'Shpee tired enter', 24, false);
		portraitShpeeTired.setGraphicSize(Std.int(portraitShpeeTired.width * PlayState.daPixelZoom * 0));
		portraitShpeeTired.updateHitbox();
		portraitShpeeTired.scrollFactor.set();
		add(portraitShpeeTired);
		portraitShpeeTired.visible = false;
	}
	if (PlayState.SONG.song.toLowerCase() == 'the-clone')
	{
		portraitShpeeTired = new FlxSprite(150, 86);
		portraitShpeeTired.frames = Paths.getSparrowAtlas('scopto/shpee_portraits');
		portraitShpeeTired.animation.addByPrefix('enter', 'Shpee tired enter', 24, false);
		portraitShpeeTired.setGraphicSize(Std.int(portraitShpeeTired.width * PlayState.daPixelZoom * 0));
		portraitShpeeTired.updateHitbox();
		portraitShpeeTired.scrollFactor.set();
		add(portraitShpeeTired);
		portraitShpeeTired.visible = false;
	}	
	if (PlayState.SONG.song.toLowerCase() == 'taking-matters')
	{
		portraitShpeeNervous = new FlxSprite(150, 86);
		portraitShpeeNervous.frames = Paths.getSparrowAtlas('scopto/shpee_portraits');
		portraitShpeeNervous.animation.addByPrefix('enter', 'Shpee tired enter', 24, false);
		portraitShpeeNervous.setGraphicSize(Std.int(portraitShpeeNervous.width * PlayState.daPixelZoom * 0));
		portraitShpeeNervous.updateHitbox();
		portraitShpeeNervous.scrollFactor.set();
		add(portraitShpeeNervous);
		portraitShpeeNervous.visible = false;
	}
	if (PlayState.SONG.song.toLowerCase() == 'the-clone')
	{
		portraitShpeeNervous = new FlxSprite(150, 86);
		portraitShpeeNervous.frames = Paths.getSparrowAtlas('scopto/shpee_portraits');
		portraitShpeeNervous.animation.addByPrefix('enter', 'Shpee tired enter', 24, false);
		portraitShpeeNervous.setGraphicSize(Std.int(portraitShpeeNervous.width * PlayState.daPixelZoom * 0));
		portraitShpeeNervous.updateHitbox();
		portraitShpeeNervous.scrollFactor.set();
		add(portraitShpeeNervous);
		portraitShpeeNervous.visible = false;
	}
	if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'roses' || PlayState.SONG.song.toLowerCase() == 'thorns')
	{
		portraitLeft = new FlxSprite(-20, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
		portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;
	}
	if (PlayState.SONG.song.toLowerCase() == 'taking-matters')
	{
		portraitAlife = new FlxSprite(150, 155);
		portraitAlife.frames = Paths.getSparrowAtlas('scopto/alife portraits');
		portraitAlife.animation.addByPrefix('enter', 'alife enter', 24, false);
		portraitAlife.setGraphicSize(Std.int(portraitAlife.width * PlayState.daPixelZoom * 0));
		portraitAlife.updateHitbox();
		portraitAlife.scrollFactor.set();
		add(portraitAlife);
		portraitAlife.visible = false;
	}	
	box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		box.updateHitbox();
		add(box);

		box.screenCenter(X);
		portraitLeft.screenCenter(X);

		handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox'));
		add(handSelect);


		if (!talkingRight)
		{
			// box.flipX = true;
		}

		dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'VCR OSD Mono';
		dropText.color = 0x00000000;
		add(dropText);

		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'VCR OSD Mono';
		swagDialogue.color = 0xFFFFFFFF;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (FlxG.keys.justPressed.ANY  && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns' || PlayState.SONG.song.toLowerCase() == 'gloomy-streets' || PlayState.SONG.song.toLowerCase() == 'taking-matters' || PlayState.SONG.song.toLowerCase() == 'the-clone')
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{
			case 'dad':
				portraitRight.visible = false;
				portraitShpee.visible = false;
				portraitShpeeAkward.visible = false;
				portraitShpeeTired.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'bf':
				portraitLeft.visible = false;
				portraitShpee.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}
			case 'bfhorrified':
				portraitLeft.visible = false;
				portraitShpee.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enterhorrified');
				}
			case 'bfkickass':
				portraitLeft.visible = false;
				portraitShpeeHappy.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enterkickasslol');
				}
			case 'shpee':
				portraitLeft.visible = false;
				portraitRight.visible = false;
				//portraitShpeeHappy.visible = false;
				if (!portraitShpee.visible)
				{
					portraitShpee.visible = true;
					portraitShpee.animation.play('enter');
				}
			case 'clone':
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitShpee.visible = false;
				if (!portraitClone.visible)
				{
					portraitClone.visible = true;
					portraitClone.animation.play('enter');
				}
			case 'shpeetired':
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitShpee.visible = false;
				portraitAlifeTone.visible = false;
				portraitAlife.visible = false;
				if (!portraitShpeeTired.visible)
				{
					portraitShpeeTired.visible = true;
					portraitShpeeTired.animation.play('enter');
				}
			case 'alifetone':
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitShpeeTired.visible = false;
				portraitShpeeAkward.visible = false;
				portraitAlife.visible = false;
				if (!portraitAlifeTone.visible)
				{
					portraitAlifeTone.visible = true;
					portraitAlifeTone.animation.play('enter');
				}
			case 'alifeakward':
				//copypaste fu
				if (FlxG.sound.music != null && FlxG.sound.music.playing) {
					FlxG.sound.music.stop();
				}
				portraitLeft.visible = false;
				portraitShpeeAkward.visible = false;
				portraitShpeeTired.visible = false;
				portraitAlife.visible = false;
				portraitAlifeTone.visible = false;
				if (!portraitAlifeAkward.visible)
				{
					portraitAlifeAkward.visible = true;
					portraitAlifeAkward.animation.play('enter');
				}
			case 'shpeeakward':
				if (wtf != null && wtf.playing) {
					wtf.stop();
				}

				wtf = new FlxSound().loadEmbedded(Paths.sound('missnote1'));
				wtf.play();
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitAlifeTone.visible = false;
				portraitAlife.visible = false;
				if (!portraitShpeeAkward.visible)
				{
					portraitShpeeAkward.visible = true;
					portraitShpeeAkward.animation.play('enter');
				}
			case 'shpeehappy':
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitShpee.visible = false;
				if (!portraitShpeeHappy.visible)
				{
					portraitShpeeHappy.visible = true;
					portraitShpeeHappy.animation.play('enter');
				}
			case 'shpeenervous':
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitClone.visible = false;
				if (!portraitShpeeNervous.visible)
				{
					portraitShpeeNervous.visible = true;
					portraitShpeeNervous.animation.play('enter');
				}
			case 'shpeehappytwo':
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitShpeeNervous.visible = false;
				if (!portraitShpeeHappy.visible)
				{
					portraitShpeeHappy.visible = true;
					portraitShpeeHappy.animation.play('enter');
				}
			case 'bfkickass2':
				//Copypaste again
				if (FlxG.sound.music != null && FlxG.sound.music.playing) {
					FlxG.sound.music.stop();
				}
				portraitLeft.visible = false;
				portraitShpeeHappy.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enterkickasslol');
				}
			case 'alife':
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitShpee.visible = false;
				portraitShpeeAkward.visible = false;
				portraitShpeeTired.visible = false;
				portraitAlifeAkward.visible = false;
				portraitAlifeTone.visible = false;
				if (!portraitAlife.visible)
				{
					portraitAlife.visible = true;
					portraitAlife.animation.play('enter');
				}	
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}
