'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "a05b607c374b0d9a03e1c372bc8e9d89",
"assets/AssetManifest.json": "f53c05cce0abea031bef77619695f419",
"assets/assets/avaters/Avatar%25201.jpg": "60f969aae689291e30cffc6deafd1ec2",
"assets/assets/avaters/Avatar%25202.jpg": "9eecb4a8f2da90198bf8c4f8c3e8c527",
"assets/assets/avaters/Avatar%25203.jpg": "4431bc261ac4f57a09dc1e041b32b4d1",
"assets/assets/avaters/Avatar%25204.jpg": "95617f142e8dcfa6547ea80557eee016",
"assets/assets/avaters/Avatar%25205.jpg": "405a74c93f4806312fcd25e7722d9f90",
"assets/assets/avaters/Avatar%25206.jpg": "57b1f154ef47c7a76a78544e9e6af44f",
"assets/assets/avaters/Avatar%2520Default.jpg": "fe9d7eaf1b437a1e6c84f1e6fdb77dcf",
"assets/assets/Backgrounds/Da.png": "f2e5f82427ac756a2bfb64cbfa228434",
"assets/assets/Backgrounds/dona.png": "42fcd80ff70dfb2f6e9a1998841ebe70",
"assets/assets/Backgrounds/fondo.png": "0d76b405a903fd16c7c3dcb0ce03305f",
"assets/assets/Backgrounds/Libro.png": "56cf1a0b5911057cdf0234897c9282eb",
"assets/assets/Backgrounds/Lifa.png": "36006fab0127351a029d2a8dbe54ee9b",
"assets/assets/Backgrounds/pe.png": "4eb89cbeb4ac767731691ccf986ba357",
"assets/assets/Backgrounds/Spline.png": "ff232f0cf3ebd732ca4383c381450714",
"assets/assets/Backgrounds/yass.png": "29ace49d769001a5eab7136676eb55b1",
"assets/assets/Fonts/Inter-Regular.ttf": "eba360005eef21ac6807e45dc8422042",
"assets/assets/Fonts/Inter-SemiBold.ttf": "3e87064b7567bef4ecd2ba977ce028bc",
"assets/assets/Fonts/Poppins-Bold.ttf": "08c20a487911694291bd8c5de41315ad",
"assets/assets/icons/Adver.png": "816b2b1533faac8f95b9a777a0006e30",
"assets/assets/icons/anas.png": "7133deb8be06dde55b2f56177e22d3da",
"assets/assets/icons/apple_box.svg": "ee51349a6f16476b0b84bf131d056a9f",
"assets/assets/icons/Arrow%2520Right.svg": "07892171f302303d4623e3d9a1c7d091",
"assets/assets/icons/arrow-ios-back-outline.svg": "618a0f240dfd9c71dc29e795eab88149",
"assets/assets/icons/Campa.png": "18e89bca5e4b1a0d88a6c5b5d74f163b",
"assets/assets/icons/check.svg": "f755b690c1f44d400ddae8e9d49dd642",
"assets/assets/icons/code.svg": "e31d64e033baf31d7c0bb09834f2dc35",
"assets/assets/icons/Codigos.png": "e44a5bb346382836b860a29283c8bb79",
"assets/assets/icons/Colegios.jpg": "bbb50a0f3eda420dbc20ae587c31f679",
"assets/assets/icons/comuni.png": "d545b7e3685156e6596693abd8effafe",
"assets/assets/icons/dedo.png": "9bb88696047fe6a0637ba6595eb20744",
"assets/assets/icons/Descripcion.png": "df5312a36eb935fad98ab3661b8ed91d",
"assets/assets/icons/Doctor.png": "0ea24ab0b559151606621a38f356e79f",
"assets/assets/icons/DonBosco.png": "5aca71c01bf6aabac996e857552226d0",
"assets/assets/icons/email.png": "63f814ee2a79ed7bcf0a9aa066aaed68",
"assets/assets/icons/email.svg": "fb18c054e3004613c033c52e8b5c63d8",
"assets/assets/icons/email_box.svg": "df947f1ccffb89669354c05a07909b9e",
"assets/assets/icons/Enfer.png": "29b6e0f75c3842af61a93bbe3439f2d8",
"assets/assets/icons/Enfermeria.png": "d92e1861658d033a7987674a53835070",
"assets/assets/icons/escuela.png": "a60c9bf2b0db1ff8aa65bf7452f6628d",
"assets/assets/icons/food_picture.png": "6d1ec470d9bc2da00fc156c737e224eb",
"assets/assets/icons/google_box.svg": "a51079e7d423e1137e45df2117d787a8",
"assets/assets/icons/Heart.svg": "613e4153e3e363c381c950ada1c8624b",
"assets/assets/icons/horario.png": "547da074a238155d21b6a0c83939375f",
"assets/assets/icons/ios.svg": "b932140aa9e4e9416b7b61a00401cf53",
"assets/assets/icons/lupa.png": "25e4c9f82fcfcbcf8e7aed5f7d8ce3f7",
"assets/assets/icons/Maria.jpg": "ef2f6c18f89a4c636db6160d49e231df",
"assets/assets/icons/Negativos.png": "f41288b3eb7fee7a4fcb7d32715ceae7",
"assets/assets/icons/noti.png": "0ad5040f1786854065ef09ee1a62ab54",
"assets/assets/icons/Notifi1.png": "893d4de5c4d535b78eff3e51dc51be1f",
"assets/assets/icons/pass.png": "c3d52cfbd97688d60d06b6755330e417",
"assets/assets/icons/password.svg": "53a71b7fa49ca079e46ff9e16f6da290",
"assets/assets/icons/Positivos.png": "da39ffb15ee8ed99bc3ed184375d96a2",
"assets/assets/icons/primero.jpg": "e987c5095365f13ed85cdd80c586b042",
"assets/assets/icons/profile_image.jpg": "2d08b40e661ee2399864f2ad24bd9ddb",
"assets/assets/icons/profile_img.png": "bdd25e977a6858b7413f720188f721c3",
"assets/assets/icons/ricaldone.png": "fecedc24485aedccc861e610803cfc6a",
"assets/assets/icons/User.svg": "c8f66efc5299fc94c56e0d576cb32164",
"assets/assets/RiveAssets/button.riv": "c8ffe2900d31d8236247928cd7c2b5f3",
"assets/assets/RiveAssets/check.riv": "14f9269423eabd7e2e10cafdc6ad4d41",
"assets/assets/RiveAssets/confetti.riv": "ad0d13cbea799085305316f0e8118274",
"assets/assets/RiveAssets/house.riv": "3ac77437a4c56b5143d6ceca83dd61d9",
"assets/assets/RiveAssets/icons.riv": "3d29f9acebef13f01f371b59e84e664b",
"assets/assets/RiveAssets/menu_button.riv": "f8fdfd9fd8dc7873dfac6f005f3233c1",
"assets/assets/RiveAssets/shapes.riv": "8839d67714d5e9c52b3e0dbb2b1e89c1",
"assets/FontManifest.json": "b2ade702843e28e1bf7dca541f902206",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/NOTICES": "1d30e4e8fec438f4c35abf7f74bc8636",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/fluttertoast/assets/toastify.js": "56e2c9cedd97f10e7e5f1cebd85d53e3",
"assets/packages/flutter_vector_icons/fonts/AntDesign.ttf": "3a2ba31570920eeb9b1d217cabe58315",
"assets/packages/flutter_vector_icons/fonts/Entypo.ttf": "31b5ffea3daddc69dd01a1f3d6cf63c5",
"assets/packages/flutter_vector_icons/fonts/EvilIcons.ttf": "140c53a7643ea949007aa9a282153849",
"assets/packages/flutter_vector_icons/fonts/Feather.ttf": "a76d309774d33d9856f650bed4292a23",
"assets/packages/flutter_vector_icons/fonts/FontAwesome.ttf": "b06871f281fee6b241d60582ae9369b9",
"assets/packages/flutter_vector_icons/fonts/FontAwesome5_Brands.ttf": "3b89dd103490708d19a95adcae52210e",
"assets/packages/flutter_vector_icons/fonts/FontAwesome5_Regular.ttf": "1f77739ca9ff2188b539c36f30ffa2be",
"assets/packages/flutter_vector_icons/fonts/FontAwesome5_Solid.ttf": "605ed7926cf39a2ad5ec2d1f9d391d3d",
"assets/packages/flutter_vector_icons/fonts/Fontisto.ttf": "b49ae8ab2dbccb02c4d11caaacf09eab",
"assets/packages/flutter_vector_icons/fonts/Foundation.ttf": "e20945d7c929279ef7a6f1db184a4470",
"assets/packages/flutter_vector_icons/fonts/Ionicons.ttf": "b3263095df30cb7db78c613e73f9499a",
"assets/packages/flutter_vector_icons/fonts/MaterialCommunityIcons.ttf": "b62641afc9ab487008e996a5c5865e56",
"assets/packages/flutter_vector_icons/fonts/MaterialIcons.ttf": "8ef52a15e44481b41e7db3c7eaf9bb83",
"assets/packages/flutter_vector_icons/fonts/Octicons.ttf": "f7c53c47a66934504fcbc7cc164895a7",
"assets/packages/flutter_vector_icons/fonts/SimpleLineIcons.ttf": "d2285965fe34b05465047401b8595dd0",
"assets/packages/flutter_vector_icons/fonts/Zocial.ttf": "1681f34aaca71b8dfb70756bca331eb2",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"canvaskit/canvaskit.js": "45bec3a754fba62b2d8f23c38895f029",
"canvaskit/canvaskit.wasm": "f516aafeb0567e650245fc457a2b7c45",
"canvaskit/chromium/canvaskit.js": "0447cabd24385be0436ab8429d76621c",
"canvaskit/chromium/canvaskit.wasm": "c0b4f8b7301098d6faa6763ae5666abe",
"canvaskit/skwasm.js": "831c0eebc8462d12790b0fadf3ab6a8a",
"canvaskit/skwasm.wasm": "28148eaa8b2578ae5b36dca4c01298cf",
"canvaskit/skwasm.worker.js": "7ec8c65402d6cd2a341a5d66aa3d021f",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "6b515e434cea20006b3ef1726d2c8894",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "f1318f94d301d1bdbd6d1e4ffc8679e3",
"/": "f1318f94d301d1bdbd6d1e4ffc8679e3",
"main.dart.js": "3a6c06506e4c6454fe911ebfeda1ae80",
"manifest.json": "bef2b02bf7b8b754500afd0d01609bec",
"version.json": "f625db1f907e6d443556b70a7c372cbd"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
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
