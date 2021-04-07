'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "6a0efda2f847da7d4065d1d04d53434b",
"index.html": "84c8a860e2dea610bb6fd8e7e02330df",
"/": "84c8a860e2dea610bb6fd8e7e02330df",
"main.dart.js": "0820cf05d876d4217d67d191966d5652",
"favicon.png": "99733c2381f7c6d7ba95874b3cfb63ba",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "1e6b01631d3dfd21795fadc73e4d3d64",
"assets/AssetManifest.json": "e947b51f74ae4120341e2da9a7d236b2",
"assets/NOTICES": "cba3c179eaa3295770b822a477ecce3c",
"assets/FontManifest.json": "3070bd9ec33b501da1c65a6b44b35455",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "d80ca32233940ebadc5ae5372ccd67f9",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "a126c025bab9a1b4d8ac5534af76a208",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "831eb40a2d76095849ba4aecd4340f19",
"assets/fonts/MaterialIcons-Regular.otf": "1288c9e28052e028aba623321f7826ac",
"assets/assets/images/time-tracking.svg": "bb613fe94e5e61266a5015fbb725557e",
"assets/assets/images/sign_in_background.png": "b55754becea244603a95d3e2462bc571",
"assets/assets/images/sign_in_logo.png": "ff2736ef2206b2ac6ef16d4738127bb6",
"assets/assets/images/acct_manager_white.gif": "6a6bd56f6795b9f31f487bf81588be40",
"assets/assets/images/3dDownArrow.gif": "b8bd4c6af82cbf671cf8a0a64b8c2f9d",
"assets/assets/images/mobileFrame2.png": "868de9b38cfa0eaf57c2084fd0e264f9",
"assets/assets/images/mobileFrame.png": "bad9a476e0928ce9b265871bd9639595",
"assets/assets/images/avatar.png": "c005e9b2f02efa0c44cc16cb8c6151a6",
"assets/assets/images/acct_manager_gif.gif": "7df25ec0175d763227ca458b34ef3c08",
"assets/assets/images/tabletFrame.png": "e528c42c664dbdb29269beeb304ba105",
"assets/assets/rive/MXOtech-stop-hug.riv": "d81d1e1a153d548600793f109e4b4891",
"assets/assets/rive/MXOtech-stop-hug2.riv": "e5d5b577e3ff990433661256c8976718",
"assets/assets/rive/MXOtech-flowy-rapid2.riv": "c9653483b573148148bdd4239bed5bc4",
"assets/assets/rive/MXOtech-flowy-rapid3.riv": "8e41c57e696c696fdbd22ceb037d55cb",
"assets/assets/rive/MXOtech-flowy-rapid.riv": "bdf6e5f8e4a22910e15dbbffc069ad72",
"assets/assets/icon/icon.png": "3f8bc33a271d5b49d5ae9e552cc979bf",
"assets/assets/icon/add_user_will.png.svg": "c9620b146a7939f48e0095a88aec8006",
"assets/assets/icon/add_company.gif": "21aa11e72d2b109e60871ea453f6fa49",
"assets/assets/icon/add_user_will.png": "92bf7f259a0750d8e710166685354e69",
"assets/assets/icon/add_technician.gif": "b35803299e24c52daa20b866df811959",
"assets/assets/icon/add_company_will.svg": "0fb02b3805e8bd92fa26b9e72b934076",
"assets/assets/icon/add_user_will.svg": "43008790b6aafce8fac6a67e0b06a88c",
"assets/assets/icon/mxotechicon.png": "3f8bc33a271d5b49d5ae9e552cc979bf",
"assets/assets/icon/path10.png": "6221e6dab296cf16088cc5c3619d4332",
"assets/assets/fonts/AllertaStencil-Regular.ttf": "11798c513db55464df5a6603790a63a2",
"assets/assets/fonts/Monoton-Regular.ttf": "411051cb61bcda5517943601e8734cea",
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
