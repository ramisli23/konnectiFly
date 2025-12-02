'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "c809bd186f0753a2cb82c3d1cec467f4",
"version.json": "7e7ed77b490d94a2b641f6d2072a81a4",
"index.html": "27131914cbe959942a62508dcd1a9948",
"/": "27131914cbe959942a62508dcd1a9948",
"main.dart.js": "d5c88c898e1a244f5f13f8d1710f6cdf",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "b6ebfca6b286400c75edfef13c908e89",
"assets/AssetManifest.json": "7b59ef9c7e07759a9c84cfad4cda47b1",
"assets/NOTICES": "605eea508b90143d171ffe9bb914cb43",
"assets/FontManifest.json": "0d5c1246a708ca21de3fd238f392ab9d",
"assets/AssetManifest.bin.json": "0fb209850a029445c8fcbb541f010c4c",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/flutter_vector_icons/fonts/Fontisto.ttf": "b49ae8ab2dbccb02c4d11caaacf09eab",
"assets/packages/flutter_vector_icons/fonts/Octicons.ttf": "f7c53c47a66934504fcbc7cc164895a7",
"assets/packages/flutter_vector_icons/fonts/Feather.ttf": "a76d309774d33d9856f650bed4292a23",
"assets/packages/flutter_vector_icons/fonts/Entypo.ttf": "31b5ffea3daddc69dd01a1f3d6cf63c5",
"assets/packages/flutter_vector_icons/fonts/FontAwesome5_Brands.ttf": "3b89dd103490708d19a95adcae52210e",
"assets/packages/flutter_vector_icons/fonts/MaterialCommunityIcons.ttf": "b62641afc9ab487008e996a5c5865e56",
"assets/packages/flutter_vector_icons/fonts/AntDesign.ttf": "3a2ba31570920eeb9b1d217cabe58315",
"assets/packages/flutter_vector_icons/fonts/Foundation.ttf": "e20945d7c929279ef7a6f1db184a4470",
"assets/packages/flutter_vector_icons/fonts/Ionicons.ttf": "b3263095df30cb7db78c613e73f9499a",
"assets/packages/flutter_vector_icons/fonts/FontAwesome5_Solid.ttf": "605ed7926cf39a2ad5ec2d1f9d391d3d",
"assets/packages/flutter_vector_icons/fonts/FontAwesome5_Regular.ttf": "1f77739ca9ff2188b539c36f30ffa2be",
"assets/packages/flutter_vector_icons/fonts/FontAwesome.ttf": "b06871f281fee6b241d60582ae9369b9",
"assets/packages/flutter_vector_icons/fonts/Zocial.ttf": "1681f34aaca71b8dfb70756bca331eb2",
"assets/packages/flutter_vector_icons/fonts/EvilIcons.ttf": "140c53a7643ea949007aa9a282153849",
"assets/packages/flutter_vector_icons/fonts/SimpleLineIcons.ttf": "d2285965fe34b05465047401b8595dd0",
"assets/packages/flutter_vector_icons/fonts/MaterialIcons.ttf": "8ef52a15e44481b41e7db3c7eaf9bb83",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "c723c65c2be06d0d6ed0ffa9561385ab",
"assets/fonts/MaterialIcons-Regular.otf": "4dba32477c0c76d2df8861490362941a",
"assets/assets/images/svg/two_factor_authentication.svg": "d8aaf53dcad7cb4dbf93007d79bffd02",
"assets/assets/images/svg/teaching.svg": "e62defc052ee479ecdade320ee9c9354",
"assets/assets/images/svg/new_message.svg": "da6d95acd405e39fba9ee7a6af9a677f",
"assets/assets/images/svg/mobile_login.svg": "a0a2c698ebfafd7fea707398ab0d3d45",
"assets/assets/images/svg/default_normal.svg": "9fd1b8b35fa0e3b1019dbf0d2563cacc",
"assets/assets/images/svg/authentication.svg": "7a2668278bccd485625d689f5b2a7a35",
"assets/assets/images/svg/mail_reduel.svg": "b6ba399988aa268f70d58881abe94b21",
"assets/assets/images/svg/my_app.svg": "77ac4a1a69e26c654f67b92f5a8c1649",
"assets/assets/images/svg/online_learning.svg": "bbf1456c11112c9ce9c5169ab0d2b8b9",
"assets/assets/images/svg/security_on.svg": "2f5d8a3225ccb9971a58e71d23e849fd",
"assets/assets/images/svg/studying.svg": "94e3bd2e4b529654aa4f6dd9d0708b67",
"assets/assets/images/svg/researching.svg": "b150718de699bd254ad4489a6f0e8275",
"assets/assets/images/svg/logo.svg": "de4097d9b47950170a0db766e8918e30",
"assets/assets/images/png/news.png": "fd9afc0280410c197ebab9036ebd61fe",
"assets/assets/images/png/verification.png": "f96bd905ace1f79667443e2b559ff949",
"assets/assets/images/png/progress.png": "2479677e7466d7fe51167594870b45dc",
"assets/assets/images/png/info_sharing.png": "0f5056a44e90bd4dd95c5bb3e434dd0b",
"assets/assets/images/png/default_normal.png": "2e4e1e7bda88522ba08a904a202b3c78",
"assets/assets/images/png/Next%2520Button.png": "83b19a07eebc06054d2cdf57a100fa6b",
"assets/assets/images/png/asia.png": "785ec5fc9f557fa1f8c0ca158c14d744",
"assets/assets/images/png/visa.png": "4cd46a6433a821a11d17b2c3199c2cb3",
"assets/assets/images/png/black_background.png": "b0d2db872347253f5b3d1e38b3bc68b1",
"assets/assets/images/png/pngegg-5.png": "ea0444f975c0562be01954bf28c4e95c",
"assets/assets/images/png/pub.png": "d1e991e12145f95665d0e3cf2547b43c",
"assets/assets/images/png/defaul_told.png": "3ef61acbdd2afe41b870085d62c67190",
"assets/assets/images/png/live_video.png": "63917d03e9b5fe34152a0d7c3e6601dc",
"assets/assets/images/png/splash.png": "d9ab51b278424fc5c7270ada618562d3",
"assets/assets/images/png/splash3.png": "f2646ca03218ab7f96666777e092313f",
"assets/assets/images/png/splash2.png": "cd065b10939413a37c4cb1f3023c624f",
"assets/assets/images/png/logo.png": "15ddfabadac5d4297c7d0f896f43cb48",
"assets/assets/images/png/analytics.png": "0ae61628f3617abf71bb8a0eb474ab46",
"assets/assets/images/png/Rectangle%25202.png": "15b91712b33861818f3954e98bee9ee3",
"assets/assets/images/png/Rectangle%25203.png": "9e5f6810dcbc589135092dc72128e959",
"assets/assets/images/png/amex.png": "b1b64a23437b1f61ae29b20016f02190",
"assets/assets/images/png/mastercard.png": "e3777ad75735623e42e24885a4452570",
"assets/assets/images/png/undraw_adventure_map_hnin%25202.png": "0085170ebf612506fd93d231b5e351fe",
"assets/assets/images/png/default_dark.png": "b17f2a1e50c327c17a5979c674f280f9",
"assets/assets/images/jpg/welcome.jpeg": "10f9bf0647332472a0f07c6fed260dff",
"assets/assets/images/jpg/travel.jpg": "3d25b68ac82ca90f9a35de31b11322c7",
"assets/assets/images/jpg/shopping.jpg": "69ce22deed9a49e35acb39fa7debf602",
"assets/assets/images/jpg/family.jpg": "5c4f52ac38586b95217b6c8542cd92bf",
"assets/assets/images/jpg/music.jpg": "ce0955feeae71cc6048cb8c608a8eee7",
"assets/assets/images/jpg/food.jpg": "80a367423a7bbd2fb5a649ef923f4de7",
"assets/assets/images/jpg/business.jpg": "e4ce8eec6dbfaeff01a0088996d15a97",
"assets/assets/images/jpg/faisal-ramdan.jpg": "48bebe7fdf43a63725a00edb0142b317",
"assets/assets/images/jpg/love.jpg": "ac4b4af447d2c4e62eafc7c66134324b",
"assets/assets/images/jpg/WhatsApp%2520Image%25202025-08-28%2520at%252022.43.20.jpeg": "9fb96ab9508280dd9d5a6063f24cb499",
"assets/assets/images/jpg/religion.jpg": "1281ab0f2d5033dc5826e8dc0c3fc3d7",
"assets/assets/images/jpg/culture.jpg": "b1c62776b2f12e47430593c3b2937383",
"assets/assets/Animation.json": "151e0a0b6812dc4dbf0ba8f9d2a06910",
"assets/assets/icons/svg/microphone.svg": "f975636af6e8c8b186a4b87606d2fcfa",
"assets/assets/icons/svg/increase.svg": "61dd343a667f923fcadbd585e2d9ee79",
"assets/assets/icons/svg/travel.svg": "99891b660f851e846ba6665bfe3b162f",
"assets/assets/icons/svg/bag.svg": "8adfb2f2526ebf49a6ac845604379af0",
"assets/assets/icons/svg/premium.svg": "ae20e0b7902acbcbe8af0bd5bb690a1b",
"assets/assets/icons/svg/pencil2.svg": "c115fd49bd9838023a882648eca4063e",
"assets/assets/icons/svg/more.svg": "47fe7137c0d7ea3044f5a9b277f66375",
"assets/assets/icons/svg/idea.svg": "69e8586aa85e085f332319292d253e82",
"assets/assets/icons/svg/pencil.svg": "c9f62b68861c5ca80d3cb709df6a329b",
"assets/assets/icons/svg/conversation.svg": "639022b6399c141c3ba6569ce8f0fa7d",
"assets/assets/icons/svg/comment.svg": "431335c0f33fd1a8f7ff87bbfc473efd",
"assets/assets/icons/svg/calendar.svg": "e64a4a545a6aed2be63cb8ebb78f273c",
"assets/assets/icons/svg/graduate.svg": "075dba3eb3d33d31c80b2502125ad755",
"assets/assets/icons/svg/level.svg": "0602552b5012fa53c0137b1efd68846b",
"assets/assets/icons/svg/menu.svg": "f7d4c4dfce63f7c8e69bee4580e962d2",
"assets/assets/icons/svg/book_school.svg": "06d409e0f47cd460843c53c0367d047a",
"assets/assets/icons/png/info.png": "4dcfb47436a0c71132741520f7192953",
"assets/assets/icons/png/wallet.png": "ede1d5ee64256b41c92f9ff02801c571",
"assets/assets/icons/png/Group.png": "4a44b2302dfee7ab61762ed1c98e763b",
"assets/assets/icons/png/calendar%2520(2).png": "bef7ae34192104eb847594a515588bdb",
"assets/assets/icons/png/Vector.png": "a241842cd3702ca21da7eeba6cc3f80c",
"assets/assets/icons/png/logo_login.png": "c7d064338f6b4a0d0dfb232a6f83d384",
"assets/assets/icons/png/out.png": "4bfdaf08506bae5f1b847d4f5b365af6",
"assets/assets/icons/png/arrow.png": "20c8d43738d00d1cdbb904908aadfab0",
"assets/assets/icons/png/information.png": "b1c8447e00f1cd51f68883b22b8a80fa",
"assets/assets/icons/png/like.png": "0c8239337435e7a683b7994cf5eeaaa1",
"assets/assets/icons/png/bookmark.png": "6e8709fe299d832bc497ff695fc536b4",
"assets/assets/icons/png/Fav%2520icon.png": "343bd25f90ff9e377d7eb4c5649f96a6",
"assets/assets/icons/png/arrow-left.png": "63beefccebb73a538410e0491f93077d",
"assets/assets/icons/png/comment.png": "6e2a7279a0400fec4aab49149aae4221",
"assets/assets/icons/png/location%2520(1).png": "87d03afc4edb7c328995afb8964502ac",
"assets/assets/icons/png/right-arrow-angle.png": "9b662a0ee1d096eb1374fa3b8a0b76c1",
"assets/assets/icons/png/Group%252018129.png": "8e6b47545354560621bb0a8cac7b1cc0",
"assets/assets/icons/png/share.png": "79053fa50ca85c1231f341b5454ad99a",
"assets/assets/icons/png/location.png": "11abdde0c31967fe44b9f8f241190db9",
"assets/assets/icons/png/phone.png": "5a31cd4e7988eb15d138be899073e97c",
"assets/assets/icons/png/gift_circle.png": "f0ede5b7c314ba6b0424d2b836213e7f",
"assets/assets/icons/png/calendar%2520(1).png": "b2c6098c212e8e922e2366c51d517869",
"assets/assets/icons/png/Group%2520(1).png": "193cbe0dca663510b36410bd6a8373e0",
"assets/assets/icons/png/google.png": "b57077797a7f35cd6d1fba4bc04739b8",
"assets/assets/icons/png/setting.png": "b06645d217f95d707c09431bb83feb72",
"assets/assets/icons/png/Back.png": "2f057e4749da81bac03f35f6ec059129",
"assets/assets/icons/png/smile.png": "06d586c1e3cf5b98cc2193729db63640",
"assets/assets/lottie/progess.json": "32ea76158bf82fd3aef03d88d44eca6a",
"assets/assets/lottie/homapage.json": "3f4563d60aa0d7ed6a2dfbef51d238a4",
"assets/assets/lottie/Trail%2520loading.json": "402c003d81255c11b459c570d23f590c",
"assets/assets/lottie/online-shopping-delivery.json": "df9668e22484c5c469c66938f003ae9b",
"assets/assets/lottie/sad-heart.json": "0800b7e5d8385691361ff02574aea7b3",
"assets/assets/lottie/search-files.json": "a0f3d167d544e4226b23929a736ef051",
"assets/assets/lottie/coffee-favorite.json": "36ba86b2830c376cc0f29545192d5637",
"assets/assets/lottie/coming-soon.json": "4b760a7787826bb668404186d2f9e5c8",
"assets/assets/lottie/orderconfomed.json": "dbf0966cbd62085ae5d5e1d47e5da375",
"assets/assets/lottie/CheckAnimation.json": "d4a8a3e5b1ff47faa2f2ce88d9d2cea3",
"assets/assets/lottie/OCL%2520Confirmed.json": "48f744bed10c974965a1cc6c21c7299e",
"assets/assets/lottie/multi-tasking.json": "86da3d7e0b222275208f1cdadbefadb2",
"assets/assets/lottie/image-icon.json": "98b306ed6f84c79258bd7572281efea6",
"assets/assets/lottie/empty-box.json": "20e62229847226f1b54b605cc6df8d8c",
"assets/assets/lottie/applications.json": "cbf46102b2183613a82fea35bfd97fcf",
"assets/assets/lottie/thinking.json": "90f3aab5b9ef693a6a8163211a3da82a",
"assets/assets/lottie/no-activity.json": "2e24a6be640974c6e83decf20a215b16",
"assets/assets/lottie/no_connexion.json": "aae7e3a8828191d032eb578b75b0796f",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
