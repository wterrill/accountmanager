'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "6a0efda2f847da7d4065d1d04d53434b",
"index.html": "5b848444b90dda63efffaef689036ccf",
"/": "5b848444b90dda63efffaef689036ccf",
"main.dart.js": "97e208b6c4a48603dfcf464bdb5bcba2",
"favicon.png": "99733c2381f7c6d7ba95874b3cfb63ba",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "1e6b01631d3dfd21795fadc73e4d3d64",
"assets/AssetManifest.json": "f487a7191659c8de9c2cf5c7958fc570",
"assets/NOTICES": "d0fd9eef6549f84006ea9a3d3e65de1f",
"assets/FontManifest.json": "7ca2153d57c68cfb916151ca28a19ef8",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "d80ca32233940ebadc5ae5372ccd67f9",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "a126c025bab9a1b4d8ac5534af76a208",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "831eb40a2d76095849ba4aecd4340f19",
"assets/fonts/MaterialIcons-Regular.otf": "1288c9e28052e028aba623321f7826ac",
"assets/assets/images/time-tracking.svg": "bb613fe94e5e61266a5015fbb725557e",
"assets/assets/images/add_company_v2.svg": "35ca35c313ddc4731082011677e5e60f",
"assets/assets/images/add_technician_v2.svg": "84144deed6863b4cd2a3eccb6b9ff288",
"assets/assets/images/acct_manager_white.gif": "6a6bd56f6795b9f31f487bf81588be40",
"assets/assets/images/3dDownArrow.gif": "b8bd4c6af82cbf671cf8a0a64b8c2f9d",
"assets/assets/images/beer.png": "34264cc903e1e50d051e3bf1f2c92292",
"assets/assets/images/vertical-logo.png": "e186bd98b44505a9c9500d77607d07ce",
"assets/assets/images/avatar.png": "c005e9b2f02efa0c44cc16cb8c6151a6",
"assets/assets/images/acct_manager_gif.gif": "7df25ec0175d763227ca458b34ef3c08",
"assets/assets/images/CMRI_sign.png": "e0518cd67be0caf343f8c2250a851687",
"assets/assets/images/add_company%2520(1).svg": "13e82f1ee1919f5764dbd319709dc3ab",
"assets/assets/images/add_comany_gimp.svg": "9a95ef0a0d1ac79003eb2b9738ec6348",
"assets/assets/images/add_company.svg": "660159e46a66b2988ab2cf70cb5018bc",
"assets/assets/images/footer-logo.png": "a54482a62d0a07dc114fd057d12034f2",
"assets/assets/images/CMRI_top.png": "3289223de011a20f25440e2addb39d65",
"assets/assets/icon/icon.png": "3f8bc33a271d5b49d5ae9e552cc979bf",
"assets/assets/icon/add_user_will.png.svg": "91afdf557126c6ca7dcfe4444cbd144e",
"assets/assets/icon/add_company.gif": "21aa11e72d2b109e60871ea453f6fa49",
"assets/assets/icon/add_user_will.png": "92bf7f259a0750d8e710166685354e69",
"assets/assets/icon/add_technician.gif": "b35803299e24c52daa20b866df811959",
"assets/assets/icon/add_company_will.svg": "0fb02b3805e8bd92fa26b9e72b934076",
"assets/assets/icon/add_user_will.svg": "43008790b6aafce8fac6a67e0b06a88c",
"assets/assets/icon/mxotechicon.png": "3f8bc33a271d5b49d5ae9e552cc979bf",
"assets/assets/icon/path10.png": "6221e6dab296cf16088cc5c3619d4332",
"assets/assets/fonts/MyFlutterApp.ttf": "f5704ba50c0d0ed5c5889ef74f902ac4",
"assets/assets/docx/template.docx": "1ef36c8eb5ae78c4752b92bbbcd883d3"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value + '?revision=' + RESOURCES[value], {'cache': 'reload'})));
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
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
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
