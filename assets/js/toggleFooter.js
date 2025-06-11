export function toggleFooter() {
  const footer = document.getElementById('dynamic-footer');

  const showFooter = () => {
    footer.classList.remove('bottom-[-100px]', 'opacity-0');
    footer.classList.add('bottom-0', 'opacity-100');
  };

  const hideFooter = () => {
    footer.classList.remove('bottom-0', 'opacity-100');
    footer.classList.add('bottom-[-100px]', 'opacity-0', 'transition-all');
  };

  const isPageScrollable = () => {
    return document.body.scrollHeight > window.innerHeight;
  };

  const checkScroll = () => {
    const scrollPosition = window.scrollY + window.innerHeight;
    const threshold = document.body.scrollHeight - 10; // A small buffer

    if (scrollPosition >= threshold) {
      showFooter();
    } else {
      hideFooter();
    }
  };

  const handleNonScrollEvent = () => {
    if (!isPageScrollable()) {
      showFooter();
    }
  };

  // Store listeners so they can be cleaned up later (e.g., in LiveView hooks)
  this.checkScrollHandler = checkScroll;
  this.wheelHandler = handleNonScrollEvent;
  this.touchmoveHandler = handleNonScrollEvent;

  window.addEventListener('scroll', this.checkScrollHandler);
  window.addEventListener('resize', this.checkScrollHandler);
  window.addEventListener('wheel', this.wheelHandler);
  window.addEventListener('touchmove', this.touchmoveHandler);

  // window.addEventListener('phx:page-loading-stop', this.checkScrollHandler);

  // Initial check
  checkScroll();
}
