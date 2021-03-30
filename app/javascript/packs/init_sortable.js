import Sortable from 'sortablejs';

const initSortable = () => {
  const list = document.querySelector('#results');
  Sortable.create(list, {
    ghostClass: "ghost",
    dragClass: "drag",
    forceFallback: true,
    animation: 200
  });
};

export { initSortable };