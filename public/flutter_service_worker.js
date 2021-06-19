'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "17a4e7967ac79736e5f7b6dc01cbf461",
"index.html": "3ef339210022e6732a211f61f2db641e",
"/": "3ef339210022e6732a211f61f2db641e",
"main.dart.js": "1dcc2a42de86b2974494b9af550dd590",
"favicon.png": "99733c2381f7c6d7ba95874b3cfb63ba",
"index_development.html": "e7ebf6e0257c32e37bdd57b8e796bc35",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "1e6b01631d3dfd21795fadc73e4d3d64",
"index_production.html": "73c674c9c09243c04c3d1076ada8353b",
"assets/AssetManifest.json": "fc2ad51f59aed4d3f615a07b9dbc2f51",
"assets/NOTICES": "0b2deb30ea64773db260ce6b3c380f10",
"assets/FontManifest.json": "3070bd9ec33b501da1c65a6b44b35455",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "dffd9504fcb1894620fa41c700172994",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "4b6a9b7c20913279a3ad3dd9c96e155b",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "00bb2b684be61e89d1bc7d75dee30b58",
"assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
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
"assets/assets/avatars/avatar_009.svg": "153e4118b84c2ccec916162b6d99d5e5",
"assets/assets/avatars/avatar_021.svg": "6242a63fe5c4c028e208c4558e12a22d",
"assets/assets/avatars/avatar_035.svg": "e4ef56941442c4b7d017725591911c79",
"assets/assets/avatars/avatar_034.svg": "18337cb5a58aa381fa1519ef92ff60cf",
"assets/assets/avatars/avatar_020.svg": "15f5dc26d7fe062cc2712175df6d708e",
"assets/assets/avatars/avatar_008.svg": "a917ab771299e1646693ef2a82eae389",
"assets/assets/avatars/avatar_036.svg": "13fabec3aee33f152c8737e269e01868",
"assets/assets/avatars/avatar_022.svg": "7b35f40a1dc8c0ca99fdab882ae74cde",
"assets/assets/avatars/avatar_023.svg": "11ab227a57b132f8b99bec0dea4d861d",
"assets/assets/avatars/avatar_037.svg": "92c1743238b47e834ac44ebd72dde9ce",
"assets/assets/avatars/avatar_033.svg": "accfb1f46ca04f26561b165c004ae322",
"assets/assets/avatars/avatar_027.svg": "637aec05e39f687c76a85261e3a78104",
"assets/assets/avatars/avatar_026.svg": "208e905a5fbe8211cd1e882e108ce4ee",
"assets/assets/avatars/avatar_032.svg": "319a261add51ef0375617d4927f9f7fa",
"assets/assets/avatars/avatar_024.svg": "2bd9378ccf8974a2dc5e1b98316024a3",
"assets/assets/avatars/avatar_030.svg": "1259a4519c211d8ed9e085a9bea11a80",
"assets/assets/avatars/avatar_018.svg": "73b56742e9652e48f4c6c76086c14680",
"assets/assets/avatars/avatar_019.svg": "f5f75632369468ed4282c279be8aa4fe",
"assets/assets/avatars/avatar_031.svg": "1c3b64155ac8615c82be4d358a5a6f99",
"assets/assets/avatars/avatar_025.svg": "8d219b8839686afe4d49b7dece847acc",
"assets/assets/avatars/avatar_122.svg": "bda1a7f590de7bfd49ab09cf954590aa",
"assets/assets/avatars/avatar_042.svg": "ff8e538d8d13be4573d5995ad0d29c20",
"assets/assets/avatars/avatar_056.svg": "3f6b2707b5098f6e4a9cf5e3d82b8970",
"assets/assets/avatars/avatar_081.svg": "9597907e0504e67a37b7efa94b854dbf",
"assets/assets/avatars/avatar_095.svg": "44ac0bcc9474d822f472d1b7e5d4652d",
"assets/assets/avatars/avatar_094.svg": "bb817fd294ef950782ba2c3d938388a9",
"assets/assets/avatars/avatar_080.svg": "93b438b79643c22f8c8a09e13e039f07",
"assets/assets/avatars/avatar_057.svg": "ecc9605b250fdb5ffaee7adba44ffaa3",
"assets/assets/avatars/avatar_043.svg": "ffed9a3e118adf45cc6216b140fb9bc6",
"assets/assets/avatars/avatar_123.svg": "de9df307abc5b953df639ba72b66d016",
"assets/assets/avatars/avatar_109.svg": "9a3704fb54e4a092803d955d95536af8",
"assets/assets/avatars/avatar_121.svg": "1a41e2cfdc1ee5fec2bd36b981831210",
"assets/assets/avatars/avatar_135.svg": "4880b3f619793ed9bb415803fc9d39eb",
"assets/assets/avatars/avatar_069.svg": "db5466379d60f1c4eda2d5b22b002f10",
"assets/assets/avatars/avatar_055.svg": "cc0bb15c5d65a9e920ba37f2e85833b4",
"assets/assets/avatars/avatar_041.svg": "646d6c9ef26a654b383fe9c242714439",
"assets/assets/avatars/avatar_096.svg": "a21cb7f1d58f764187095066642373f6",
"assets/assets/avatars/avatar_082.svg": "301e4b77d215d5f2cf93486428fa473a",
"assets/assets/avatars/avatar_083.svg": "01e6dadeb0a285af324c93427cf9ef9f",
"assets/assets/avatars/avatar_097.svg": "0d4d4b6e37263f016a602955abea78c2",
"assets/assets/avatars/avatar_040.svg": "a2dee69628a20df5e19fd75f63700b24",
"assets/assets/avatars/avatar_054.svg": "91e95c2afc702ed8ac07101deeb0c729",
"assets/assets/avatars/avatar_068.svg": "1fbfccba6515bab2710a4bf2354deafe",
"assets/assets/avatars/avatar_134.svg": "1eaaf12d25811bbd2356d668dbcd21dd",
"assets/assets/avatars/avatar_120.svg": "225b665b8623127c0463eb90d95e4ccc",
"assets/assets/avatars/avatar_108.svg": "ec0e85e62e3ac00892e82fc3291f561b",
"assets/assets/avatars/avatar_124.svg": "fd1049115674d00cf1a3ebb3416c0271",
"assets/assets/avatars/avatar_130.svg": "6324a90cb148279b4a178d409d645d32",
"assets/assets/avatars/avatar_118.svg": "24cfe57d5aa4b1ae3ffd48e469eff23b",
"assets/assets/avatars/avatar_050.svg": "500c22c2ed707dce72c9a60571180f6a",
"assets/assets/avatars/avatar_044.svg": "43187fee5cda3d7d4dfd38f19d7b0292",
"assets/assets/avatars/avatar_078.svg": "98df24ba7eac7eb4fda4143df022ead0",
"assets/assets/avatars/avatar_093.svg": "0f3b32a62716b9b2c9bdc18c929a8408",
"assets/assets/avatars/avatar_087.svg": "c5b28ef9b09eb9a5f8962221aaf972fe",
"assets/assets/avatars/avatar_086.svg": "61231e7a7d066e2e735f734880101cb8",
"assets/assets/avatars/avatar_092.svg": "1539ff0f6aa9d59ef5025065b63ab5a5",
"assets/assets/avatars/avatar_079.svg": "7778a933b8b15266e09fd60259b81dce",
"assets/assets/avatars/avatar_045.svg": "58067b5b41bf42381093a32271c2714d",
"assets/assets/avatars/avatar_051.svg": "d103072be58c51a320fdcd9e39d66737",
"assets/assets/avatars/avatar_119.svg": "84624c785b39d6a9c0631a78d663eb12",
"assets/assets/avatars/avatar_131.svg": "6c462553e54d405380633ed0976bc06b",
"assets/assets/avatars/avatar_125.svg": "fe08faa58268257ef0f5216424a1e967",
"assets/assets/avatars/avatar_133.svg": "1766d4a0627cc5ac0c355e3d5ad3f2f8",
"assets/assets/avatars/avatar_127.svg": "bbaadadca9624f3db36dc3d755b62c59",
"assets/assets/avatars/avatar_047.svg": "41b1a13301bc7dcb8418339dc23b4562",
"assets/assets/avatars/avatar_053.svg": "d8178fede87de2d4630e0c49e77d7d4b",
"assets/assets/avatars/avatar_084.svg": "8c33e16ef4339f1f6233a106dcf1c9be",
"assets/assets/avatars/avatar_090.svg": "051195cca3bace582c8ee78242b140e9",
"assets/assets/avatars/avatar_091.svg": "0917597cd9297f5c2b4c8b6db2ea74aa",
"assets/assets/avatars/avatar_085.svg": "7766f9359f5e3428029a2324866050cd",
"assets/assets/avatars/avatar_052.svg": "afeeb19813827b37c906daf450539bcd",
"assets/assets/avatars/avatar_046.svg": "9bd14ad11be2aad338fd6ac5244a898e",
"assets/assets/avatars/avatar_126.svg": "96c3bb886387d6921264a3d51a9e848e",
"assets/assets/avatars/avatar_132.svg": "e19bf105602981aca9fb0bd9306ae252",
"assets/assets/avatars/avatar_117.svg": "4c363bf2b7b210e3008c88d1d7b5faba",
"assets/assets/avatars/avatar_103.svg": "c447d08a11a8cd1125129763dfd9eadc",
"assets/assets/avatars/avatar_063.svg": "53dacde69ee902a2af6574a51b94a8ac",
"assets/assets/avatars/avatar_077.svg": "cd18872389cdafd68a0e0707ed984a47",
"assets/assets/avatars/avatar_088.svg": "337c2de10f9c61c46b82a578c1e227cc",
"assets/assets/avatars/avatar_089.svg": "f5cc35307d0a92553b87f843728d1006",
"assets/assets/avatars/avatar_076.svg": "530767ff6d225482549d0bc6d8e92ed2",
"assets/assets/avatars/avatar_062.svg": "e9db1cf0ebb9d756eca6f4a6dcb96855",
"assets/assets/avatars/avatar_102.svg": "f9284f3cf545106e16b9bf2c18826d98",
"assets/assets/avatars/avatar_116.svg": "b828054a7fe737b35823a38707ea50b1",
"assets/assets/avatars/avatar_128.svg": "fd10d8c0a1089424952163242f58d971",
"assets/assets/avatars/avatar_100.svg": "b06bf11076ce4d957f07526c13fae1a9",
"assets/assets/avatars/avatar_114.svg": "39ed896878dd9e37e80dc9b1a02a715f",
"assets/assets/avatars/avatar_048.svg": "ffd3365c7f3c93ad65d8b9ba79853cde",
"assets/assets/avatars/avatar_074.svg": "95f8a95bbeecdc6101481ba6830b4a46",
"assets/assets/avatars/avatar_060.svg": "869d7b18472d53b59b47dba943a438ee",
"assets/assets/avatars/avatar_061.svg": "357b95b211c1620c155a2a90878ea8fe",
"assets/assets/avatars/avatar_075.svg": "32c8bfaf4de78e16f1118d22126ebfba",
"assets/assets/avatars/avatar_049.svg": "2e9844bc9ce9aac874fa6ec17202b070",
"assets/assets/avatars/avatar_115.svg": "fe9023aee4f96037fcdb4fa118779186",
"assets/assets/avatars/avatar_101.svg": "c9e8a98a1e220e328f301950b0f6276e",
"assets/assets/avatars/avatar_129.svg": "4af4bb5cbf3126e250089c1547209016",
"assets/assets/avatars/avatar_105.svg": "40f62fc578c2530cf0d70da881fe2361",
"assets/assets/avatars/avatar_111.svg": "dfaa270fa4b69a88d10c4d242fee1fa4",
"assets/assets/avatars/avatar_071.svg": "4e3308880147030873ac56d0d29821e0",
"assets/assets/avatars/avatar_065.svg": "1cb7ce537076c96425159ad01f74f48b",
"assets/assets/avatars/avatar_059.svg": "f8ca4299c839c7f5beed0e371e7aefad",
"assets/assets/avatars/avatar_058.svg": "efee6a2ffbf702573682e2c77a5d2d06",
"assets/assets/avatars/avatar_064.svg": "0223101e44193f3ba936d28e9ac2957d",
"assets/assets/avatars/avatar_070.svg": "b09583cb8a9c6e00601d02397e89a97e",
"assets/assets/avatars/avatar_110.svg": "26189e42d29378da419846a3f666a073",
"assets/assets/avatars/avatar_104.svg": "39be876fab6a2a2816ba72fb0ef0ecbc",
"assets/assets/avatars/avatar_112.svg": "7373a76c0f7d204f2de4e4be9e4f2e89",
"assets/assets/avatars/avatar_106.svg": "9c14094a2e5a52737b1dd27a586c7de3",
"assets/assets/avatars/avatar_066.svg": "70542a852b51356eb6bb0455e78b3ff8",
"assets/assets/avatars/avatar_072.svg": "1e81a3666cac2c11dd4f758052d0f2cf",
"assets/assets/avatars/avatar_099.svg": "4b3025b975e3c536581908bf4e060574",
"assets/assets/avatars/avatar_098.svg": "c7989cbf0539f44476dea57008f17349",
"assets/assets/avatars/avatar_073.svg": "caa8a5f96d9bca1bf0805bf0b9e9e7c7",
"assets/assets/avatars/avatar_067.svg": "65104aaf216c910e01155d233263ed1c",
"assets/assets/avatars/avatar_107.svg": "7c50eff7d191ef684e8dcc408457231f",
"assets/assets/avatars/avatar_113.svg": "4fb9bb94b56eb1a2a43390dce86a5e6e",
"assets/assets/avatars/avatar_028.svg": "5cddf2bddde77b29082fa6777f0ba042",
"assets/assets/avatars/avatar_000.svg": "f2681752e6ade71fb4bd33d5d3cf7680",
"assets/assets/avatars/avatar_014.svg": "843474c240ad0e136d957d93f8609e10",
"assets/assets/avatars/avatar_015.svg": "0e5163984e0ef7e782b94a4b71fc9403",
"assets/assets/avatars/avatar_001.svg": "2f492f73268fe0821d538371c9ee3af6",
"assets/assets/avatars/avatar_029.svg": "a0dd6cb84c5668f8d2225aef2eae3560",
"assets/assets/avatars/avatar_017.svg": "7a87f86077c27b529ea5cdb02e13ced8",
"assets/assets/avatars/avatar_003.svg": "ba7bc78863f27f9c2a1ad2a7106b5738",
"assets/assets/avatars/avatar_002.svg": "d6dbd89e356777d35c78ffa5b574df38",
"assets/assets/avatars/avatar_016.svg": "0c8a89a16ff6e24339608e6a79eb635a",
"assets/assets/avatars/avatar_012.svg": "effb4f6ed0f18f5988239d81eaee2cf1",
"assets/assets/avatars/avatar_006.svg": "ea225df8392fd25b6f8a9bf15669e0f2",
"assets/assets/avatars/avatar_007.svg": "d49672efbdbd4ebb397ff0caa63afdbc",
"assets/assets/avatars/avatar_013.svg": "350536a1ec543838ecb08e74ea8cb188",
"assets/assets/avatars/rename_script.sh": "ad34327217354506025b095f1446e32c",
"assets/assets/avatars/avatar_005.svg": "92cbdccf3abe57a20f35751fb570c6de",
"assets/assets/avatars/avatar_011.svg": "4e697eb2f688e305153e161c1112a8db",
"assets/assets/avatars/avatar_039.svg": "6be58f0628bb982ed24010c9c06498a4",
"assets/assets/avatars/avatar_038.svg": "a0a6eff37065ba59222f66a001c0516b",
"assets/assets/avatars/avatar_010.svg": "953e8e31eb4aa5841dd364180357b137",
"assets/assets/avatars/avatar_004.svg": "c070ac125ce294a2a5a306b8499b0fb2",
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
