/**
 * FLearn Landing Page — Interactive JavaScript
 * Scroll animations, counter animations, navbar effects, code tabs
 */
(function () {
    'use strict';

    /* ───────────────────────────────────────────────
       1. Navbar scroll effect
       ─────────────────────────────────────────────── */
    const navbar = document.getElementById('landingNavbar');
    if (navbar) {
        const onScroll = () => {
            if (window.scrollY > 50) {
                navbar.classList.add('scrolled');
            } else {
                navbar.classList.remove('scrolled');
            }
        };
        window.addEventListener('scroll', onScroll, { passive: true });
        onScroll(); // run on load
    }

    /* ───────────────────────────────────────────────
       2. Scroll-triggered animations (IntersectionObserver)
       ─────────────────────────────────────────────── */
    const animatedEls = document.querySelectorAll('.fade-up, .fade-left, .fade-right, .scale-in');
    if (animatedEls.length > 0 && 'IntersectionObserver' in window) {
        const observer = new IntersectionObserver(
            (entries) => {
                entries.forEach((entry) => {
                    if (entry.isIntersecting) {
                        entry.target.classList.add('visible');
                        observer.unobserve(entry.target);
                    }
                });
            },
            { threshold: 0.15, rootMargin: '0px 0px -40px 0px' }
        );
        animatedEls.forEach((el) => observer.observe(el));
    }

    /* ───────────────────────────────────────────────
       3. Animated counters
       ─────────────────────────────────────────────── */
    const counters = document.querySelectorAll('[data-count]');
    if (counters.length > 0 && 'IntersectionObserver' in window) {
        const counterObserver = new IntersectionObserver(
            (entries) => {
                entries.forEach((entry) => {
                    if (entry.isIntersecting) {
                        animateCounter(entry.target);
                        counterObserver.unobserve(entry.target);
                    }
                });
            },
            { threshold: 0.5 }
        );
        counters.forEach((c) => counterObserver.observe(c));
    }

    function animateCounter(el) {
        const target = parseInt(el.getAttribute('data-count'), 10);
        const suffix = el.getAttribute('data-suffix') || '';
        const prefix = el.getAttribute('data-prefix') || '';
        const duration = 2000; // ms
        const start = performance.now();

        function update(now) {
            const elapsed = now - start;
            const progress = Math.min(elapsed / duration, 1);
            // Ease out cubic
            const eased = 1 - Math.pow(1 - progress, 3);
            const current = Math.round(eased * target);
            el.textContent = prefix + current.toLocaleString('vi-VN') + suffix;
            if (progress < 1) {
                requestAnimationFrame(update);
            }
        }
        requestAnimationFrame(update);
    }

    /* ───────────────────────────────────────────────
       4. Progress bar animation (hero card)
       ─────────────────────────────────────────────── */
    const progressBars = document.querySelectorAll('.progress-bar-fill[data-width]');
    if (progressBars.length > 0) {
        setTimeout(() => {
            progressBars.forEach((bar) => {
                bar.style.width = bar.getAttribute('data-width');
            });
        }, 800);
    }

    /* ───────────────────────────────────────────────
       5. Code tabs switching
       ─────────────────────────────────────────────── */
    const codeTabs = document.querySelectorAll('.code-tab-btn');
    codeTabs.forEach((tab) => {
        tab.addEventListener('click', () => {
            const target = tab.getAttribute('data-tab');
            // Remove active from all tabs
            document.querySelectorAll('.code-tab-btn').forEach((t) => t.classList.remove('active'));
            document.querySelectorAll('.code-panel').forEach((p) => p.classList.remove('active'));
            // Activate clicked
            tab.classList.add('active');
            const panel = document.getElementById(target);
            if (panel) {
                panel.classList.add('active');
                // Re-highlight with Prism if available
                if (window.Prism) {
                    Prism.highlightAllUnder(panel);
                }
            }
        });
    });

    /* ───────────────────────────────────────────────
       6. Smooth scroll for anchor links
       ─────────────────────────────────────────────── */
    document.querySelectorAll('a[href^="#"]').forEach((anchor) => {
        anchor.addEventListener('click', function (e) {
            const href = this.getAttribute('href');
            if (href && href !== '#') {
                const target = document.querySelector(href);
                if (target) {
                    e.preventDefault();
                    target.scrollIntoView({ behavior: 'smooth', block: 'start' });
                }
            }
        });
    });

    /* ───────────────────────────────────────────────
       7. Parallax-like effect for hero shapes
       ─────────────────────────────────────────────── */
    const heroShapes = document.querySelectorAll('.hero-bg-shapes .shape');
    if (heroShapes.length > 0) {
        window.addEventListener('mousemove', (e) => {
            const x = (e.clientX / window.innerWidth - 0.5) * 2;
            const y = (e.clientY / window.innerHeight - 0.5) * 2;
            heroShapes.forEach((shape, i) => {
                const speed = (i + 1) * 8;
                shape.style.transform = `translate(${x * speed}px, ${y * speed}px)`;
            });
        }, { passive: true });
    }

    /* ───────────────────────────────────────────────
       8. Active nav link highlighting on scroll
       ─────────────────────────────────────────────── */
    const sections = document.querySelectorAll('section[id]');
    if (sections.length > 0) {
        window.addEventListener('scroll', () => {
            const scrollPos = window.scrollY + 120;
            sections.forEach((section) => {
                const top = section.offsetTop;
                const height = section.offsetHeight;
                const id = section.getAttribute('id');
                const link = document.querySelector(`.landing-navbar a[href*="#${id}"]`);
                if (link) {
                    if (scrollPos >= top && scrollPos < top + height) {
                        link.classList.add('active');
                    } else {
                        link.classList.remove('active');
                    }
                }
            });
        }, { passive: true });
    }

})();
