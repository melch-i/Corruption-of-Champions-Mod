/**
 * Coded by aimozg on 30.09.2017.
 */
package coc.view {

	import classes.EngineCore;
	import classes.internals.Utils;

	public class ButtonDataList {
		public function ButtonDataList() {
		}
		public var list: /*ButtonData*/Array = [];

		private var _page: int = 0;

		public function get page(): int {
			return _page;
		}

		public function get length(): int {
			return list.length;
		}

		public function add(text: String, callback: Function = null, toolTipText: String = "", toolTipHeader: String = ""): ButtonData {
			var bd: ButtonData = new ButtonData(text, callback, toolTipText, toolTipHeader);
			list.push(bd);
			return bd;
		}

		public function push(button: ButtonData): ButtonData {
			list.push(button);
			return button;
		}

		public function clear(): void {
			list.splice(0);
		}

		public function submenu(back: Function = null, page: int = 0, sort: Boolean = true): void {
			_page = page;
			var lst: /*ButtonData*/Array = list.filter(function (e: ButtonData, i: int, a: Array): Boolean {
				return e.visible;
			});
			if (sort) {
				lst.sortOn('text');
			}
			EngineCore.menu();
			var total: int = lst.length;
			var perPage: int = 12;
			if (total <= 14) {
				perPage = 14;
			}
			var n: int = Math.min(total, (page + 1) * perPage);
			for (var bi: int = 0, li: int = page * perPage; li < n; li++, bi++) {
				lst[li].applyTo(EngineCore.button(bi % perPage));
			}
			if (page != 0 || total > perPage) {
				EngineCore.button(12).show("Prev Page", Utils.curry(submenu, back, page - 1, sort)).disableIf(page == 0);
				EngineCore.button(13).show("Next Page", Utils.curry(submenu, back, page + 1, sort)).disableIf(n >= total);
			}
			if (back != null) {
				EngineCore.button(14).show("Back", back);
			}
		}
	}
}
