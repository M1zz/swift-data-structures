// ═══════════════════════════════════════════════════════════════
//  Leeo Sites — Unified Google Analytics 4
//  Measurement ID: G-FG0Q3EQFWM
//
//  같은 파일을 세 레포에 복사해 사용합니다.
//   - LeeoNote                /LeeoNote/js/analytics.js
//   - swift-data-structures   /swift-data-structures/docs/assets/analytics.js
//   - cs-swiftUI              /cs-swiftUI/docs/assets/analytics.js
//
//  hostname 은 모두 m1zz.github.io. 프로젝트는 pathname 의
//  첫 세그먼트로 자동 식별됩니다.
//
//  하이어라키
//  ───────────────────────────────────────────────────────────────
//   L0 홈 (LeeoNote /)
//    ├─ L1 철학, 서재, 생각, 도구, 편지함, 혼자 만들기
//    └─ L1 아카데미
//         ├─ L2 Swift 자료구조   (swift-data-structures /)
//         │    └─ L3 학습 · 치트시트 · 문제 · 면접 · 가이드
//         └─ L2 CS × SwiftUI     (cs-swiftUI /)
//              ├─ L3 Stage 1 ─ L4 1-1 / 1-2 / 1-3 / 1-4
//              ├─ L3 Stage 2 ─ L4 2-1 / 2-2 / 2-3 / 2-4
//              ├─ L3 클론 코딩 ─ L4 projects/*
//              └─ L3 블로그 · 셋업 · 문법 · 컴포넌트 레퍼런스
// ═══════════════════════════════════════════════════════════════

(function () {
  var GA_ID = 'G-FG0Q3EQFWM';

  // 1) gtag.js 로드
  var s = document.createElement('script');
  s.async = true;
  s.src = 'https://www.googletagmanager.com/gtag/js?id=' + GA_ID;
  (document.head || document.documentElement).appendChild(s);

  window.dataLayer = window.dataLayer || [];
  function gtag() { window.dataLayer.push(arguments); }
  window.gtag = gtag;
  gtag('js', new Date());

  // ─────────────────────────────────────────────────────────────
  //  분류기
  // ─────────────────────────────────────────────────────────────

  function detectProject(pathname) {
    if (/^\/LeeoNote(\/|$)/.test(pathname)) return 'LeeoNote';
    if (/^\/swift-data-structures(\/|$)/.test(pathname)) return 'sds';
    if (/^\/cs-swiftUI(\/|$)/.test(pathname)) return 'cs';
    return 'local';
  }

  function stripPrefix(pathname) {
    return pathname.replace(/^\/(LeeoNote|swift-data-structures|cs-swiftUI)/, '') || '/';
  }

  function normalize(path) {
    return path.split('?')[0].split('#')[0].replace(/\/index\.html$/, '/') || '/';
  }

  function classify(absolutePath) {
    var project = detectProject(absolutePath);
    var path = normalize(stripPrefix(absolutePath));

    if (project === 'LeeoNote') return classifyLeeoNote(path);
    if (project === 'sds')      return classifySDS(path);
    if (project === 'cs')       return classifyCS(path);
    return { l1: 'Other', depth: 99, group: 'Other', project: project };
  }

  // ── LeeoNote ───────────────────────────────────────────────────
  function classifyLeeoNote(p) {
    if (p === '/' || p === '') return mk('LeeoNote', { l1: '홈', depth: 0, parent: null });

    var topMap = {
      '/philosophy.html':  { l1: '철학',         parent: '홈' },
      '/library.html':     { l1: '서재',         parent: '홈' },
      '/thoughts.html':    { l1: '생각',         parent: '홈' },
      '/academy.html':     { l1: '아카데미',     parent: '홈' },
      '/tools.html':       { l1: '도구',         parent: '홈' },
      '/mentoring.html':   { l1: '편지함',       parent: '홈' },
      '/join.html':        { l1: '혼자 만들기',  parent: '홈' },
      '/join-career.html': { l1: '혼자 만들기',  parent: '홈' },
      '/join-launcher.html': { l1: '혼자 만들기', parent: '홈' }
    };
    if (topMap[p]) return mk('LeeoNote', Object.assign({ depth: 1 }, topMap[p]));

    if (p === '/solo-builders/') return mk('LeeoNote',
      { l1: '혼자 만들기', l2: '솔로 빌딩 노트', depth: 2, parent: '혼자 만들기' });
    if (p === '/solo-builders/app-store-checklist.html') return mk('LeeoNote',
      { l1: '혼자 만들기', l2: '솔로 빌딩 노트', l3: 'App Store 출시', depth: 3, parent: '솔로 빌딩 노트' });
    if (p === '/solo-builders/monetization-worksheet.html') return mk('LeeoNote',
      { l1: '혼자 만들기', l2: '솔로 빌딩 노트', l3: '오래 만드는 일', depth: 3, parent: '솔로 빌딩 노트' });

    return mk('LeeoNote', { l1: 'Other', depth: 99, parent: null });
  }

  // ── swift-data-structures (아카데미 하위) ────────────────────────
  function classifySDS(p) {
    if (p === '/' || p === '') return mk('sds',
      { l1: '아카데미', l2: 'Swift 자료구조', depth: 2, parent: '아카데미' });

    var pages = {
      '/learn.html':         '학습',
      '/cheatsheet.html':    '치트시트',
      '/problems.html':      '문제',
      '/interview.html':     '면접',
      '/swift-ds-guide.html':'가이드',
      '/book.html':          '책'
    };
    if (pages[p]) return mk('sds',
      { l1: '아카데미', l2: 'Swift 자료구조', l3: pages[p], depth: 3, parent: 'Swift 자료구조' });

    // /products/* — 자료
    var m = p.match(/^\/products\/([^/]+)\.html$/);
    if (m) return mk('sds',
      { l1: '아카데미', l2: 'Swift 자료구조', l3: '자료', l4: m[1], depth: 4, parent: '자료' });

    return mk('sds',
      { l1: '아카데미', l2: 'Swift 자료구조', l3: 'Other', depth: 99, parent: 'Swift 자료구조' });
  }

  // ── cs-swiftUI (아카데미 하위) ────────────────────────────────────
  function classifyCS(p) {
    // /en/ 언어판 → 동일 분류 + lang 태그
    var lang = 'ko';
    if (/^\/en\//.test(p)) { lang = 'en'; p = p.replace(/^\/en/, ''); }

    if (p === '/' || p === '') {
      var h = mk('cs', { l1: '아카데미', l2: 'CS × SwiftUI', depth: 2, parent: '아카데미' });
      h.lang = lang; return h;
    }

    // 스테이지 허브
    var hub = { '/stage1.html': 'Stage 1', '/stage2.html': 'Stage 2', '/clone-coding.html': '클론 코딩' };
    if (hub[p]) {
      var hh = mk('cs', { l1: '아카데미', l2: 'CS × SwiftUI', l3: hub[p], depth: 3, parent: 'CS × SwiftUI' });
      hh.lang = lang; return hh;
    }

    // 챕터 1-1 ~ 1-4
    var m1 = p.match(/^\/1-(\d)\.html$/);
    if (m1) {
      var h1 = mk('cs', { l1: '아카데미', l2: 'CS × SwiftUI', l3: 'Stage 1', l4: '1-' + m1[1], depth: 4, parent: 'Stage 1' });
      h1.lang = lang; return h1;
    }
    var m2 = p.match(/^\/2-(\d)\.html$/);
    if (m2) {
      var h2 = mk('cs', { l1: '아카데미', l2: 'CS × SwiftUI', l3: 'Stage 2', l4: '2-' + m2[1], depth: 4, parent: 'Stage 2' });
      h2.lang = lang; return h2;
    }

    // 프로젝트 가이드
    var mp = p.match(/^\/projects\/([^/]+)\.html$/);
    if (mp) {
      var hp = mk('cs', { l1: '아카데미', l2: 'CS × SwiftUI', l3: '클론 코딩', l4: mp[1], depth: 4, parent: '클론 코딩' });
      hp.lang = lang; return hp;
    }

    // 단일 자료 페이지
    var single = {
      '/blog.html':          '블로그',
      '/setup.html':         '셋업',
      '/swift-grammar.html': 'Swift 문법',
      '/component-ref.html': '컴포넌트 레퍼런스'
    };
    if (single[p]) {
      var hs = mk('cs', { l1: '아카데미', l2: 'CS × SwiftUI', l3: single[p], depth: 3, parent: 'CS × SwiftUI' });
      hs.lang = lang; return hs;
    }

    var ho = mk('cs', { l1: '아카데미', l2: 'CS × SwiftUI', l3: 'Other', depth: 99, parent: 'CS × SwiftUI' });
    ho.lang = lang; return ho;
  }

  function mk(project, fields) {
    var root = (project === 'LeeoNote') ? ['홈'] : ['홈', '아카데미'];
    var added = [];
    if (fields.l1 && root[root.length - 1] !== fields.l1) added.push(fields.l1);
    if (fields.l2) added.push(fields.l2);
    if (fields.l3) added.push(fields.l3);
    if (fields.l4) added.push(fields.l4);
    var group = root.concat(added).join(' > ');
    return Object.assign({ project: project, group: group }, fields);
  }

  // ─────────────────────────────────────────────────────────────
  //  현재 페이지 분류 → 초기 설정
  // ─────────────────────────────────────────────────────────────

  var rawPath = location.pathname + location.search;
  var cleanPath = rawPath.replace(/^\/(LeeoNote|swift-data-structures|cs-swiftUI)(\/|$)/, '/');
  var h = classify(location.pathname);

  gtag('config', GA_ID, {
    page_path: cleanPath,
    page_title: document.title,
    content_group: h.group,
    transport_type: 'beacon',
    anonymize_ip: true
  });

  gtag('set', 'user_properties', {
    project: h.project
  });

  gtag('set', {
    section_l1: h.l1 || '(none)',
    section_l2: h.l2 || '(none)',
    section_l3: h.l3 || '(none)',
    section_l4: h.l4 || '(none)',
    page_depth: h.depth,
    page_parent: h.parent || '(root)',
    page_lang: h.lang || 'ko'
  });

  // ─────────────────────────────────────────────────────────────
  //  이벤트
  // ─────────────────────────────────────────────────────────────

  // 외부 링크
  document.addEventListener('click', function (e) {
    var a = e.target.closest && e.target.closest('a[href]');
    if (!a) return;
    var href = a.href || '';
    if (!href || href.indexOf('http') !== 0) return;
    // 같은 호스트(m1zz.github.io 안의 형제 프로젝트)는 internal_nav 로 잡힘
    try {
      var u = new URL(href);
      if (u.hostname === location.hostname) return;
    } catch (_) {}
    gtag('event', 'outbound_click', {
      url: href,
      from_section: h.l1 || '(none)',
      from_project: h.project,
      link_text: (a.textContent || '').trim().substring(0, 80),
      transport_type: 'beacon'
    });
  });

  // 내부 네비게이션 — 같은 호스트(형제 프로젝트 포함)
  document.addEventListener('click', function (e) {
    var a = e.target.closest && e.target.closest('a[href]');
    if (!a) return;
    var href = a.getAttribute('href') || '';
    if (!href || href.indexOf('mailto:') === 0 || href.indexOf('#') === 0) return;
    try {
      var target = new URL(a.href, location.href);
      if (target.hostname !== location.hostname) return;
      var to = classify(target.pathname);
      var crossesProject = to.project !== h.project;
      gtag('event', 'internal_nav', {
        from_path: cleanPath,
        from_section: h.l1 || '(none)',
        from_project: h.project,
        to_path: target.pathname,
        to_section: to.l1 || '(none)',
        to_project: to.project,
        crosses_project: crossesProject,
        depth_delta: (to.depth ?? 99) - (h.depth ?? 0),
        transport_type: 'beacon'
      });
    } catch (_) {}
  });

  // 스크롤 깊이
  var tracked = {};
  window.addEventListener('scroll', function () {
    var html = document.documentElement;
    var scrollable = html.scrollHeight - html.clientHeight;
    if (scrollable <= 0) return;
    var pct = Math.round((html.scrollTop / scrollable) * 100);
    [25, 50, 75, 100].forEach(function (t) {
      if (pct >= t && !tracked[t]) {
        tracked[t] = true;
        gtag('event', 'scroll_depth', {
          percent: t,
          page_path: cleanPath,
          section: h.l1 || '(none)',
          project: h.project,
          transport_type: 'beacon'
        });
      }
    });
  }, { passive: true });

  // 체류 시간
  var enteredAt = Date.now();
  window.addEventListener('pagehide', function () {
    var seconds = Math.round((Date.now() - enteredAt) / 1000);
    if (seconds < 1) return;
    gtag('event', 'page_dwell', {
      seconds: seconds,
      page_path: cleanPath,
      section: h.l1 || '(none)',
      project: h.project,
      depth: h.depth,
      transport_type: 'beacon'
    });
  });
})();
