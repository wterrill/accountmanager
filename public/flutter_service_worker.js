'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "6a0efda2f847da7d4065d1d04d53434b",
"index.html": "261477314f5a2f3b676b71b2ff2d2739",
"/": "261477314f5a2f3b676b71b2ff2d2739",
"main.dart.js": "a66f30e530d7a46150dd89edbec18547",
"favicon.png": "99733c2381f7c6d7ba95874b3cfb63ba",
"index_development.html": "e7ebf6e0257c32e37bdd57b8e796bc35",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "1e6b01631d3dfd21795fadc73e4d3d64",
"index_production.html": "73c674c9c09243c04c3d1076ada8353b",
"assets/AssetManifest.json": "101e5965169808f0d7c4947fe7d21343",
"assets/NOTICES": "2979733d66cc931bef258a575ca4c262",
"assets/FontManifest.json": "3070bd9ec33b501da1c65a6b44b35455",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "dffd9504fcb1894620fa41c700172994",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "4b6a9b7c20913279a3ad3dd9c96e155b",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "00bb2b684be61e89d1bc7d75dee30b58",
"assets/fonts/MaterialIcons-Regular.otf": "1288c9e28052e028aba623321f7826ac",
"assets/assets/svg/avatars_all_2.svg": "a36d3758ebbd92e2b885a9057f92d973",
"assets/assets/svg/avatar_test2.svg": "16aaa0d5fff5afc4e099bba011e6b6b6",
"assets/assets/svg/avatar_test4.svg": "302265fb21869ed8f19606232facfef6",
"assets/assets/svg/avatar_mean_dude.svg": "f57b9886887a282f3cd2b27764f27b77",
"assets/assets/svg/avatar_test2=9.svg": "14e84bba049fd4d87157bbd69ae93b69",
"assets/assets/svg/avatar2.svg": "bbb881b2cd2f5bd36be0695f259be54a",
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
"assets/assets/rive/mxotechNewVersion.riv": "618edd8c9e22a093b8c8d07c720ffae0",
"assets/assets/icon/icon.png": "3f8bc33a271d5b49d5ae9e552cc979bf",
"assets/assets/icon/add_user_will.png.svg": "c9620b146a7939f48e0095a88aec8006",
"assets/assets/icon/add_company.gif": "21aa11e72d2b109e60871ea453f6fa49",
"assets/assets/icon/add_user_will.png": "92bf7f259a0750d8e710166685354e69",
"assets/assets/icon/add_technician.gif": "b35803299e24c52daa20b866df811959",
"assets/assets/icon/add_company_will.svg": "0fb02b3805e8bd92fa26b9e72b934076",
"assets/assets/icon/add_user_will.svg": "43008790b6aafce8fac6a67e0b06a88c",
"assets/assets/icon/mxotechicon.png": "3f8bc33a271d5b49d5ae9e552cc979bf",
"assets/assets/icon/path10.png": "6221e6dab296cf16088cc5c3619d4332",
"assets/assets/avatars/avatar_32.svg": "319a261add51ef0375617d4927f9f7fa",
"assets/assets/avatars/avatar_26.svg": "208e905a5fbe8211cd1e882e108ce4ee",
"assets/assets/avatars/avatar_27.svg": "637aec05e39f687c76a85261e3a78104",
"assets/assets/avatars/avatar_33.svg": "accfb1f46ca04f26561b165c004ae322",
"assets/assets/avatars/avatar_19.svg": "f5f75632369468ed4282c279be8aa4fe",
"assets/assets/avatars/avatar_25.svg": "8d219b8839686afe4d49b7dece847acc",
"assets/assets/avatars/avatar_31.svg": "1c3b64155ac8615c82be4d358a5a6f99",
"assets/assets/avatars/avatar_30.svg": "1259a4519c211d8ed9e085a9bea11a80",
"assets/assets/avatars/avatar_24.svg": "2bd9378ccf8974a2dc5e1b98316024a3",
"assets/assets/avatars/avatar_18.svg": "73b56742e9652e48f4c6c76086c14680",
"assets/assets/avatars/avatar_20.svg": "15f5dc26d7fe062cc2712175df6d708e",
"assets/assets/avatars/avatar_34.svg": "18337cb5a58aa381fa1519ef92ff60cf",
"assets/assets/avatars/avatar_08.svg": "a917ab771299e1646693ef2a82eae389",
"assets/assets/avatars/avatar_09.svg": "153e4118b84c2ccec916162b6d99d5e5",
"assets/assets/avatars/avatar_35.svg": "e4ef56941442c4b7d017725591911c79",
"assets/assets/avatars/avatar_21.svg": "6242a63fe5c4c028e208c4558e12a22d",
"assets/assets/avatars/avatar_37.svg": "92c1743238b47e834ac44ebd72dde9ce",
"assets/assets/avatars/avatar_23.svg": "11ab227a57b132f8b99bec0dea4d861d",
"assets/assets/avatars/avatar_22.svg": "7b35f40a1dc8c0ca99fdab882ae74cde",
"assets/assets/avatars/avatar_36.svg": "13fabec3aee33f152c8737e269e01868",
"assets/assets/avatars/avatar_45.svg": "58067b5b41bf42381093a32271c2714d",
"assets/assets/avatars/avatar_44.svg": "43187fee5cda3d7d4dfd38f19d7b0292",
"assets/assets/avatars/avatar_50.svg": "500c22c2ed707dce72c9a60571180f6a",
"assets/assets/avatars/avatar_46.svg": "9bd14ad11be2aad338fd6ac5244a898e",
"assets/assets/avatars/avatar_47.svg": "41b1a13301bc7dcb8418339dc23b4562",
"assets/assets/avatars/avatar_43.svg": "ffed9a3e118adf45cc6216b140fb9bc6",
"assets/assets/avatars/avatar_42.svg": "ff8e538d8d13be4573d5995ad0d29c20",
"assets/assets/avatars/avatar_40.svg": "a2dee69628a20df5e19fd75f63700b24",
"assets/assets/avatars/avatar_41.svg": "646d6c9ef26a654b383fe9c242714439",
"assets/assets/avatars/avatar_49.svg": "2e9844bc9ce9aac874fa6ec17202b070",
"assets/assets/avatars/avatar_48.svg": "ffd3365c7f3c93ad65d8b9ba79853cde",
"assets/assets/avatars/avatar_13.svg": "350536a1ec543838ecb08e74ea8cb188",
"assets/assets/avatars/avatar_07.svg": "d49672efbdbd4ebb397ff0caa63afdbc",
"assets/assets/avatars/avatar_06.svg": "ea225df8392fd25b6f8a9bf15669e0f2",
"assets/assets/avatars/avatar_12.svg": "effb4f6ed0f18f5988239d81eaee2cf1",
"assets/assets/avatars/avatar_38.svg": "a0a6eff37065ba59222f66a001c0516b",
"assets/assets/avatars/avatar_04.svg": "c070ac125ce294a2a5a306b8499b0fb2",
"assets/assets/avatars/avatar_10.svg": "953e8e31eb4aa5841dd364180357b137",
"assets/assets/avatars/avatar_11.svg": "4e697eb2f688e305153e161c1112a8db",
"assets/assets/avatars/avatar_05.svg": "92cbdccf3abe57a20f35751fb570c6de",
"assets/assets/avatars/avatar_39.svg": "6be58f0628bb982ed24010c9c06498a4",
"assets/assets/avatars/avatar_01.svg": "2f492f73268fe0821d538371c9ee3af6",
"assets/assets/avatars/avatar_15.svg": "0e5163984e0ef7e782b94a4b71fc9403",
"assets/assets/avatars/avatar_29.svg": "a0dd6cb84c5668f8d2225aef2eae3560",
"assets/assets/avatars/avatar_28.svg": "5cddf2bddde77b29082fa6777f0ba042",
"assets/assets/avatars/avatar_14.svg": "843474c240ad0e136d957d93f8609e10",
"assets/assets/avatars/avatar_16.svg": "0c8a89a16ff6e24339608e6a79eb635a",
"assets/assets/avatars/avatar_02.svg": "d6dbd89e356777d35c78ffa5b574df38",
"assets/assets/avatars/avatar_03.svg": "ba7bc78863f27f9c2a1ad2a7106b5738",
"assets/assets/avatars/avatar_17.svg": "7a87f86077c27b529ea5cdb02e13ced8",
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
