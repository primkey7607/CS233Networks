Client request:
GET http://weirdorconfusing.com/js/weird-or-confusing.js HTTP/1.1
Host: weirdorconfusing.com
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:57.0) Gecko/20100101 Firefox/57.0
Accept: */*
Accept-Language: en-US,en;q=0.5
Accept-Encoding: gzip, deflate
Referer: http://weirdorconfusing.com/
Connection: keep-alive


Server response:
HTTP/1.1 200 OK
x-amz-id-2: exSvCkwtQ/Qvc/v/U9jTitzNIDqQdtwddBjMP7b715JYQuHlWpQDhDLGUAs18LuFzJMFpE+KVmE=
x-amz-request-id: 636F8631ED2079FB
Date: Sun, 03 Dec 2017 03:21:48 GMT
Last-Modified: Mon, 18 Sep 2017 20:57:55 GMT
ETag: "1e19d4f3897d945e3ec7a4d4cdaa325b"
Content-Type: application/javascript
Content-Length: 11734
Server: AmazonS3

function uselessWebButton(button, popup) {
	// UI elements
	var buttonElement = button;
	var popupElement = popup;

	var initialClick = false;
	var randomRange = 10;

	var sitesList = [
		[
			// unicorn horn for cats
			'https://rover.ebay.com/rover/1/711-53200-19255-0/1?ff3=4&toolid=11800&pub=5575330747&campid=5338181172&mpre=http%3A%2F%2Fwww.ebay.com%2Fitm%2FInflatable-Unicorn-Horn-For-Cats%2F282581794662%3Fepid%3D691244490%26hash%3Ditem41cb2fff66%253Ag%253AFREAAOSwPxtZcrXC'
		],
		[
			'https://rover.ebay.com/rover/1/711-53200-19255-0/1?ff3=4&toolid=11800&pub=5575330747&campid=5338181172&mpre=http%3A%2F%2Fwww.ebay.com%2Fitm%2F332335109732'
		],
		[
			// unicorn meat
			'https://rover.ebay.com/rover/1/711-53200-19255-0/1?ff3=4&toolid=11800&pub=5575330747&campid=5338181172&mpre=http%3A%2F%2Fwww.ebay.com%2Fitm%2FThinkGeek-Canned-Unicorn-Meat-5-5-Ounce-New-%2F281983866255%3Fepid%3D1287207669%26hash%3Ditem41a78c558f%3Ag%3AJr0AAOSwyltZVZQH'
		],
		[
			// singing pickle
			'https://rover.ebay.com/rover/1/711-53200-19255-0/1?ff3=4&toolid=11800&pub=5575330747&campid=5338181172&mpre=http%3A%2F%2Fwww.ebay.com%2Fitm%2FYodelling-Pickle-%2F201518365205%3Fepid%3D1500102028%26hash%3Ditem2eeb6e3a15%3Ag%3AL~cAAOSwFMZWtRhQ'
		],
		[
			// bacon bandages
			'https://rover.ebay.com/rover/1/711-53200-19255-0/1?ff3=4&toolid=11800&pub=5575330747&campid=5338181172&mpre=http%3A%2F%2Fwww.ebay.com%2Fitm%2FBacon-Bandages-%2F201673247314%3Fepid%3D1901622817%26hash%3Ditem2ef4a98a52%3Ag%3A39IAAOSwv-NWVndo'
		],
		[
			// Fish "assholes"
			'https://rover.ebay.com/rover/1/711-53200-19255-0/1?ff3=4&toolid=11800&pub=5575330747&campid=5338181172&mpre=http%3A%2F%2Fwww.ebay.com%2Fitm%2FFunny-Fun-Joke-Christmas-Stocking-Stuffer-Gag-Gift-Fish-Ass-Holes-Label-Only%2F352154710939%3Fepid%3D511661772%26hash%3Ditem51fe0e739b%253Ag%253ALp0AAOSwBLlVB7kS'
		],
		[
			// Dog pooping calendar
			'https://rover.ebay.com/rover/1/711-53200-19255-0/1?ff3=4&toolid=11800&pub=5575330747&campid=5338181172&mpre=http%3A%2F%2Fwww.ebay.com%2Fitm%2F2018-Pooping-Pooches-Dog-Calendar-White-Elephant-Gag-Gift-Exchange-or-Yankee-Sw%2F292229513741%3Fhash%3Ditem440a3c820d%253Ag%253AaKIAAOSwU2VZo2Mc'
		],
		[
			// Banana Slicer
			'https://rover.ebay.com/rover/1/711-53200-19255-0/1?ff3=4&toolid=11800&pub=5575330747&campid=5338181172&mpre=http%3A%2F%2Fwww.ebay.com%2Fitm%2FKitchen-Tool-New-Salad-Cutter-Chopper-Fruit-Peeler-Banana-Slicer-%2F272522077480%3Fhash%3Ditem3f7394e528%3Ag%3AQ4wAAOSwA3dYen9C'
		],
		[
			'https://rover.ebay.com/rover/1/711-53200-19255-0/1?ff3=4&toolid=11800&pub=5575330747&campid=5338181172&mpre=http%3A%2F%2Fwww.ebay.com%2Fitm%2FCTA-Digital-Adjustable-Pedestal-Stand-iPad-Optional-Toilet-Roll-Holder-Bathroom-%2F122129088668%3Fhash%3Ditem1c6f76009c%3Ag%3A~54AAOSwGtRX1Yaq'
		], // Ipad holder what?
		[
			'https://rover.ebay.com/rover/1/711-53200-19255-0/1?ff3=4&toolid=11800&pub=5575330747&campid=5338181172&mpre=http%3A%2F%2Fwww.ebay.com%2Fitm%2FPLAY-VISIONS-NOVELTY-450-NOSE-AEROBICS-%2F253045909261%3Fepid%3D1510381887%26hash%3Ditem3aeab6270d%3Ag%3AYxsAAOSwJq1ZaTZc'
		], // Nose aerobics?
		[
			'https://rover.ebay.com/rover/1/711-53200-19255-0/1?ff3=4&toolid=11800&pub=5575330747&campid=5338181172&mpre=http%3A%2F%2Fwww.ebay.com%2Fitm%2FPup-A-Razzi-Pop-Queen-Dog-Costume-X-Small-Gold-New-%2F322595167139%3Fepid%3D0%26hash%3Ditem4b1c2b9ba3%3Ag%3Ah-YAAOSwiA9Za0Jw'
		], // Weird AF dog costume
		[
			'https://rover.ebay.com/rover/1/711-53200-19255-0/1?ff3=4&toolid=11800&pub=5575330747&campid=5338181172&mpre=http%3A%2F%2Fwww.ebay.com%2Fitm%2FThe-Purrfect-DVD-Cat-Entertainment-Video-%2F262913713461%3Fepid%3D1110296699%26hash%3Ditem3d36e0e535%3Ag%3AFrEAAOSwol5Y2nee'
		], // Cat DVD
		[
			'https://rover.ebay.com/rover/1/711-53200-19255-0/1?ff3=4&toolid=11800&pub=5575330747&campid=5338181172&mpre=http%3A%2F%2Fwww.ebay.com%2Fitm%2FA-MILLION-RANDOM-DIGITS-WITH-100000-NORMAL-DEVIATES-Hardcover-BRAND-NEW-%2F182754789929%3Fepid%3D1942719%26hash%3Ditem2a8d08ca29%3Ag%3ARssAAOSwLQpZszTf'
		], // Book of random numbers
		[
			'https://rover.ebay.com/rover/1/711-53200-19255-0/1?ff3=4&toolid=11800&pub=5575330747&campid=5338181172&mpre=http%3A%2F%2Fwww.ebay.com%2Fitm%2FCrafting-With-Cat-Hair-by-Kaori-Tsutays-2011-NEW-%2F253126465204%3Fepid%3D108952077%26hash%3Ditem3aef8356b4%3Ag%3A4qoAAOSwtRBZqCRc'
		], // Crafting with cat hair
		[
			'https://rover.ebay.com/rover/1/711-53200-19255-0/1?ff3=4&toolid=11800&pub=5575330747&campid=5338181172&mpre=http%3A%2F%2Fwww.ebay.com%2Fitm%2FFlair-Hair-Visor-with-Brown-Hair-Mossey-Oak-Camo-New-%2F352024538490%3Fepid%3D1230222485%26hash%3Ditem51f64c2d7a%3Ag%3A7H4AAOSw4CFY5-qH'
		], // Hair hat

		[
			'https://rover.ebay.com/rover/1/711-53200-19255-0/1?ff3=4&toolid=11800&pub=5575330747&campid=5338181172&mpre=http%3A%2F%2Fwww.ebay.com%2Fitm%2FGift-of-Nothing-%2F142436266547%3Fhash%3Ditem2129dcf233%3Ag%3AJAwAAOSwVJhZXNm5'
		], // Gift of nothing
		[
			'http://www.ebay.com/itm/Toysmith-Headgames-Velcro-Game-Kids-Fun-Activity-/132261669682?epid=691146723&hash=item1ecb68eb32:g:IG8AAOSwKoRZaZGD'
		], // Velcro head game
		[
			'https://rover.ebay.com/rover/1/711-53200-19255-0/1?ff3=4&toolid=11800&pub=5575330747&campid=5338181172&mpre=http%3A%2F%2Fwww.ebay.com%2Fitm%2FBed-Prism-Spectacles-Horizontal-Bed-Reading-Lying-Down-Watching-TV-Lazy-Glasses-%2F362084875209%3Fvar%3D%26hash%3Ditem544df0bbc9%3Am%3AmKXSmXVf1sPxeTigKm6EdEA'
		], // Weird lying down glasses
		[
			'https://rover.ebay.com/rover/1/711-53200-19255-0/1?ff3=4&toolid=11800&pub=5575330747&campid=5338181172&mpre=http%3A%2F%2Fwww.ebay.com%2Fitm%2FGoats-in-Trees-2017-Square-%2F142250379141%3Fepid%3D1663244718%26hash%3Ditem211ec88785%3Ag%3An34AAOSwo4pYf9S-'
		], // Goats in tree's (multilingual)
		[
			'https://rover.ebay.com/rover/1/711-53200-19255-0/1?ff3=4&toolid=11800&pub=5575330747&campid=5338181172&mpre=http%3A%2F%2Fwww.ebay.com%2Fitm%2FFashion-Custom-Home-Decor-Pilllowcase-Nicolas-Cage-Pillow-Case-Cover-20x30-Inch-%2F201695597716%3Fepid%3D2114300012%26hash%3Ditem2ef5fe9494%3Ag%3A99kAAOSwo4pYCIQ1'
		], // Nick Cage pillowcase
		[
			'https://rover.ebay.com/rover/1/711-53200-19255-0/1?ff3=4&toolid=11800&pub=5575330747&campid=5338181172&mpre=http%3A%2F%2Fwww.ebay.com%2Fitm%2FDancing-with-Cats-From-the-Creators-of-the-International-Best-Seller-Why-Cats-P-%2F252741157790%3Fepid%3D169983594%26hash%3Ditem3ad88c039e%3Ag%3A270AAOSw44BYiat1'
		], // Dancing with cats
		[
			'https://rover.ebay.com/rover/1/711-53200-19255-0/1?ff3=4&toolid=11800&pub=5575330747&campid=5338181172&mpre=http%3A%2F%2Fwww.ebay.com%2Fitm%2FLEARNING-TO-PLAY-WITH-A-LIONS-TESTICLES-HAYNES-MELISSA-J-NEW-PAPERBACK-BO-%2F142451010585%3Fepid%3D160018486%26hash%3Ditem212abdec19%3Ag%3A-S0AAOSwc2tZb~dj'
		], // Lions nads
		[
			'https://rover.ebay.com/rover/1/711-53200-19255-0/1?ff3=4&toolid=11800&pub=5575330747&campid=5338181172&mpre=http%3A%2F%2Fwww.ebay.com%2Fitm%2FKama-Pootra-%2F142092361771%3Fepid%3D80058233%26hash%3Ditem21155d602b%3Ag%3As9MAAOSwawpXuIUb'
		], // Different ways to poop!
		[
			'https://rover.ebay.com/rover/1/711-53200-19255-0/1?ff3=4&toolid=11800&pub=5575330747&campid=5338181172&mpre=http%3A%2F%2Fwww.ebay.com%2Fitm%2F100-PCS-WHOLESALE-FINGER-LIGHT-UP-RING-LASER-LED-RAVE-PARTY-FAVORS-GLOW-BEAMS-%2F331778600108%3Fepid%3D0%26hash%3Ditem4d3f8bacac%3Ag%3A0OMAAOSwuAVWwXP-'
		], // Finger lights
		[
			'https://rover.ebay.com/rover/1/711-53200-19255-0/1?ff3=4&toolid=11800&pub=5575330747&campid=5338181172&mpre=http%3A%2F%2Fwww.ebay.com%2Fitm%2FBatle-Studio-Retired-design-Shell-Graphite-Pencil-dated-2004-06-NIB-%2F222336936628%3Fhash%3Ditem33c4506ab4%3Ag%3AyrEAAOSw5cNYRjil'
		], // Graphite Pencil thing
		[
			'https://rover.ebay.com/rover/1/711-53200-19255-0/1?ff3=4&toolid=11800&pub=5575330747&campid=5338181172&mpre=http%3A%2F%2Fwww.ebay.com%2Fitm%2FHanderpants-Underpants-Hands-Underwear-Gag-Gift-Novelty-Item-Funny-Warm-Hands-%2F282457315534%3Fepid%3D0%26hash%3Ditem41c3c498ce%3Ag%3AQZwAAOSwdjNZCLYB'
		], // Hand underpants
		[
			'https://rover.ebay.com/rover/1/711-53200-19255-0/1?ff3=4&toolid=11800&pub=5575330747&campid=5338181172&mpre=http%3A%2F%2Fwww.ebay.com%2Fitm%2FKnitting-with-Dog-Hair-by-Kendall-Crolius-Anne-Montgomery-Paperback-1996-%2F401389570802%3Fepid%3D95169977%26hash%3Ditem5d74aecaf2%3Ag%3AG68AAOSw5VtZvbzH'
		], // Knitting with dog hair
		[
			'https://rover.ebay.com/rover/1/711-53200-19255-0/1?ff3=4&toolid=11800&pub=5575330747&campid=5338181172&mpre=http%3A%2F%2Fwww.ebay.com%2Fitm%2FShittens-Disposable-Mitten-shaped-Moist-Wipes-20-Count-New-%2F281737477356%3Fepid%3D1617529518%26hash%3Ditem4198dcbcec%3Ag%3Au4kAAOSwRXRZVbkB'
		], // Shittens
		[
			'https://rover.ebay.com/rover/1/711-53200-19255-0/1?ff3=4&toolid=11800&pub=5575330747&campid=5338181172&mpre=http%3A%2F%2Fwww.ebay.com%2Fitm%2FVintage-Creepy-Clown-Evil-Grin-PHOTO-Freak-Scary-Child-Weird-Doll-Strange-Smile-%2F222626241703%3Fhash%3Ditem33d58edca7%3Ag%3AqlIAAOSwPCVX8Cro'
		],
		[
			'https://rover.ebay.com/rover/1/711-53200-19255-0/1?ff3=4&toolid=11800&pub=5575330747&campid=5338181172&mpre=http%3A%2F%2Fwww.ebay.com%2Fitm%2FUnique-Shaped-Cheeto-American-Bald-Eagle-Perched-On-Tree-One-Of-A-Kind-Weird-%2F232217746288%3Fhash%3Ditem3611419b70%3Ag%3ASiMAAOSwFV9Xwy~d'
		],
		[
			'https://rover.ebay.com/rover/1/711-53200-19255-0/1?ff3=4&toolid=11800&pub=5575330747&campid=5338181172&mpre=http%3A%2F%2Fwww.ebay.com%2Fitm%2FFREAKY-WEIRD-Odd-Creepy-Strange-Grasshopper-Hunter-Spooky-VINTAGE-4x6-PHOTO-1845-%2F302454631330%3Fhash%3Ditem466bb36ba2%3Ag%3AblUAAOSwRwhZs1xR'
		],
		[
			'https://rover.ebay.com/rover/1/711-53200-19255-0/1?ff3=4&toolid=11800&pub=5575330747&campid=5338181172&mpre=http%3A%2F%2Fwww.ebay.com%2Fitm%2FSubtle-Butt-disposable-gas-neutralizers-5-pack-FUNNY-STOCKING-STUFFER-%2F302162904093%3Fepid%3D1400393964%26hash%3Ditem465a50041d%3Ag%3AjRUAAOSwgmJXzz8B'
		], // fart stopper
		['https://www.amazon.com/gp/offer-listing/0870334336/'], // How to avoid large ships (book)
		[
			'https://www.amazon.com/UFO-Detector-magnetometer-interfaced-microcontroller/dp/B000FVUKKO'
		], // Weird UFO detector
		[
			'https://rover.ebay.com/rover/1/711-53200-19255-0/1?ff3=4&toolid=11800&pub=5575330747&campid=5338181172&mpre=http%3A%2F%2Fwww.ebay.com%2Fitm%2FNap-Sack-Prank-Pack-Your-Gift-Recipient-Will-be-Speechless-%2F132054370383%3Fhash%3Ditem1ebf0dc84f%3Ag%3AEdAAAOSw241YbSga'
		],
		[
			// Nap Sack
			'https://www.amazon.com/Keyboard-Customized-Key_board-comfortable-accessories/dp/B00IPPANMM/'
		], // wtf keyboard
		[
			'https://www.amazon.com/Electronic-Spin-Bottle-University-Games/dp/B000096QFW'
		] // Electric Spin the Bottle
	];

	var sites = null;

	// Prepares and binds the button
	var init = function() {
		button.onclick = onButtonClick;
		sites = sitesList.slice(0);

		// Check for past data
		if (localStorage['site'] !== undefined) {
			loadSites();
		}
	};

	// Selects and removes the next website from the list
	var selectWebsite = function() {
		var site, range, index;

		range = randomRange > sites.length ? sites.length : randomRange;
		index = Math.floor(Math.random() * range);

		site = sites[index];
		sites.splice(index, 1);

		return site;
	};

	// Opens the given url in a new window
	var openSite = function(url) {
		window.open(url);
	};

	var onButtonClick = function() {
		var url = selectWebsite()[0];
		openSite(url);

		// User has visited ALL the sites... refresh the list.
		if (sites.length == 0) {
			sites = sitesList.slice(0);
		}

		storeSites();
	};

	// Save the current list of sites for the new user.
	var storeSites = function() {
		localStorage['site'] = JSON.stringify(sites);
	};

	// Load the list of sites, so new users see new sites.
	var loadSites = function() {
		sites = JSON.parse(localStorage['site']);
	};

	init();
}
