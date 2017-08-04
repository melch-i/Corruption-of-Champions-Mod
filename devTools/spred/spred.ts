/*
 * Created by aimozg on 27.07.2017.
 * Confidential until published on GitHub
 */
///<reference path="typings/jquery.d.ts"/>

type Dict<T> = { [index: string]: T };
type TDrawable = HTMLImageElement | HTMLCanvasElement | HTMLVideoElement | ImageBitmap;

namespace spred {
	const basedir = window['spred_basedir'] || '../../';
	
	export function RGBA(i: tinycolorInstance): number {
		let rgb = i.toRgb();
		return (
				   ((rgb.a * 0xff) & 0xff) << 24
				   | (rgb.b & 0xff) << 16
				   | (rgb.g & 0xff) << 8
				   | (rgb.r & 0xff)
			   ) >>> 0;
	}
	
	/*
	function mkimg(colors: string[][]): HTMLCanvasElement {
		const hex     = {a: 10, b: 11, c: 12, d: 13, e: 14, f: 15, A: 10, B: 11, C: 12, D: 13, E: 14, F: 15};
		let canvas    = document.createElement('canvas');
		let w         = colors[0].length;
		let h         = colors.length;
		canvas.width  = w;
		canvas.height = h;
		let c2d       = canvas.getContext('2d');
		let id        = c2d.getImageData(0, 0, w, h);
		let px        = id.data;
		let i         = 0;
		for (let y = 0; y < h; y++) {
			for (let x = 0; x < w; x++) {
				let rgb    = colors[y][x];
				let r: any = rgb.charAt(0), g: any = rgb.charAt(1), b: any = rgb.charAt(2);
				r          = hex[r] || +r;
				g          = hex[g] || +g;
				b          = hex[b] || +b;
				px[i++]    = (r << 4) | r;
				px[i++]    = (g << 4) | g;
				px[i++]    = (b << 4) | b;
				px[i++]    = 0xff;
			}
		}
		c2d.putImageData(id, 0, 0);
		return canvas;
	}
	*/
	
	export function $new(selector: string = 'div', ...content: (string | JQuery | Element)[]): JQuery {
		let ss      = selector.split(/\./);
		let tagName = ss[0] || 'div';
		let d       = document.createElement(tagName);
		d.className = ss.slice(1).join(' ');
		if (tagName == 'button') (d as HTMLButtonElement).type = 'button';
		if (tagName == 'a') (d as HTMLAnchorElement).href = 'javascript:void(0)';
		return $(d).append(content);
	}
	
	export function newCanvas(width: number, height: number,
							  code: (ctx2d: CanvasRenderingContext2D) => any = () => {}): HTMLCanvasElement {
		let canvas    = document.createElement('canvas');
		canvas.width  = width;
		canvas.height = height;
		code(canvas.getContext('2d'));
		return canvas;
	}
	
	export function paletteOptions(palette: Dict<string>): JQuery[] {
		return Object.keys(palette).map(name => $new('option', name).attr('value', palette[name]));
	}
	
	export class Layer {
		constructor(
			public name:string,
			public readonly sprite:Sprite,
			public dx:number,
			public dy:number
		) {
		
		}
	}
	
	export class Composite {
		public ui: JQuery;
		
		private _layers: Dict<boolean> = {};
		public readonly canvas: HTMLCanvasElement;
		public readonly colormap: Dict<string> = {};
		
		public get layerNames(): string[] {
			return this.model.layers.filter(l => this._layers[l.name]).map(l=>l.name);
		}
		
		public set layerNames(value: string[]) {
			this._layers = value.reduce((r,e)=>{r[e]=true; return r},{} as Dict<boolean>);
		}
		
		public redraw(x: number = 0,
					  y: number = 0,
					  w: number = this.model.width,
					  h: number = this.model.height) {
			let ctx2d                   = this.canvas.getContext('2d');
			ctx2d.imageSmoothingEnabled = false;
			let z                       = this.zoom;
			ctx2d.clearRect(x * z, y * z, w * z, h * z);
			let p0   = new Promise<CanvasRenderingContext2D>((resolve, reject) => {
				resolve(ctx2d);
			});
			let cmap = [] as [number, number][];
			for (let ck of this.model.colorkeys) {
				if (!(ck.base in this.colormap)) continue;
				let base = tinycolor(this.colormap[ck.base]);
				if (ck.transform) for (let tf of ck.transform.split(',')) {
					let m = tf.match(/^([a-z]+)\((\d+)\)$/);
					if (m && m[1] in base) base = (base[m[1]] as Function).apply(base, [+m[2]]) as tinycolorInstance;
				}
				cmap.push([RGBA(tinycolor(ck.src)), RGBA(base)]);
			}
			for (let a = this.model.layers, i = a.length - 1; i >= 0; i--) {
				let layer = a[i];
				if (this._layers[layer.name]) {
					let sprite = this.model.sprites[layer.name];
					let idata = sprite.ctx2d.getImageData(x, y, w, h);
					idata     = colormap(idata, cmap);
					p0.then(ctx2d => {
						return createImageBitmap(idata).then(bmp => {
							let sx = x, sy = y;
							let sw = w;
							let sh = h;
							let dx = layer.dx+sprite.dx;
							let dy = layer.dy+sprite.dy;
							if (dx < 0) {
								sx -= dx;
								dx = 0;
							}
							if (dy < 0) {
								sy -= dy;
								dy = 0;
							}
							if (dx + sw > this.model.width) sw = this.model.width - dx;
							if (dy + sh > this.model.height) sh = this.model.height - dy;
							if (sx + sw > sprite.width) sw = sprite.width - sx;
							if (sy + sh > sprite.height) sh = sprite.height - sy;
							ctx2d.drawImage(bmp, sx, sy, sw, sh, dx * z, dy * z, sw * z, sh * z);
							return ctx2d;
						})
					});
				}
			}
		}
		
		public hideAll(name: string) {
			this._layers = {};
		}
		
		public isVisible(layerName: string) {
			return this._layers[layerName];
		}
		
		public setVisible(layerName: string, visibility: boolean) {
			this._layers[layerName] = visibility;
		}
		
		public get zoom(): number {
			return this.canvas.width / this.model.width;
		}
		
		public set zoom(value: number) {
			value              = Math.max(1, value | 0);
			this.canvas.width  = this.model.width * value;
			this.canvas.height = this.model.height * value;
			this.redraw();
		}
		
		constructor(public readonly model: Model,
					visibleNames: string[] = [],
					zoom: number           = 1) {
			this.canvas = newCanvas(model.width * zoom, model.height * zoom);
			this.canvas.setAttribute('focusable', 'true');
			this.layerNames = visibleNames.slice(0);
			this.redraw();
		}
	}
	
	export class Sprite {
		public ui: JQuery;
		public readonly canvas: HTMLCanvasElement;
		public readonly ctx2d: CanvasRenderingContext2D;
		
		updateUI() {
			let c2d = (this.ui.find('canvas')[0] as HTMLCanvasElement).getContext('2d');
			let cw=this.width,ch = this.height;
			c2d.drawImage(this.canvas, 0, 0, cw>ch?32:32*ch/cw, cw>ch?32*ch/cw:32);
		}
		
		constructor(public readonly name: string,
					public readonly width: number,
					public readonly height: number,
					src: TDrawable,
					srcX: number,
					srcY: number,
					public dx: number,
					public dy: number) {
			this.canvas        = document.createElement('canvas');
			this.canvas.width  = width;
			this.canvas.height = height;
			this.ctx2d         = this.canvas.getContext('2d');
			this.ctx2d.drawImage(src, srcX, srcY, width, height, 0, 0, width, height);
		}
	}
	
	function url2img(src: string): Promise<HTMLImageElement> {
		return new Promise<HTMLImageElement>((resolve, reject) => {
			let i2 = $('img[src="'+ src+ '"]');
			if (i2[0]) {
				resolve(i2[0] as HTMLImageElement);
				return
			}
			let img    = document.createElement('img');
			img.onload = (e) => {
				resolve(img);
			};
			img.src    = src;
		});
	}
	
	export class Spritesheet {
		public cellwidth: number;
		public cellheight: number;
		public rows: string[][];
		public img: HTMLImageElement;
		public sprites: Dict<Sprite> = {};
		
		public isLoaded(): boolean {
			return this.img != null;
		}
		
		public readonly whenLoaded: Promise<Spritesheet>;
		
		constructor(modeldir: string, src: Element) {
			let x           = $(src);
			this.cellwidth  = +x.attr('cellwidth');
			this.cellheight = +x.attr('cellheight');
			this.sprites    = {};
			
			this.whenLoaded =
				url2img(modeldir + x.attr('file')
				).then(img => {
					let positions = {} as Dict<[number, number]>;
					x.children("row").each((i, row) => {
						let names = row.textContent.split(',');
						for (let j = 0; j < names.length; j++) {
							if (names[j]) positions[names[j]] = [this.cellwidth * j, this.cellheight * i];
						}
					});
					Object.keys(positions)
						  .forEach(key => {
							  this.sprites[key] = new Sprite(key, this.cellheight, this.cellwidth, img, positions[key][0], positions[key][1], 0, 0);
						  });
					this.img = img;
					return this;
				});
		}
	}
	
	export class Spritemap {
		public img: HTMLImageElement;
		public sprites: Dict<Sprite> = {};
		
		public isLoaded(): boolean {
			return this.img != null;
		}
		
		public readonly whenLoaded: Promise<Spritemap>;
		
		constructor(modeldir: string, src: Element) {
			let x           = $(src);
			this.sprites    = {};
			this.whenLoaded =
				url2img(modeldir + x.attr('file')
				).then(img => {
					x.children("cell").each((i, cell) => {
						let name           = cell.getAttribute('name');
						let rect = (cell.getAttribute('rect')||'').match(/^(\d+),(\d+),(\d+),(\d)+$/);
						let x,y,w,h;
						if (rect) {
							[x,y,w,h] = [+rect[1],+rect[2],+rect[3],+rect[4]];
						} else {
							x = +cell.getAttribute('x');
							y = +cell.getAttribute('y');
							w = +cell.getAttribute('w');
							h = +cell.getAttribute('h');
						}
						this.sprites[name] = new Sprite(
							name, w, h, img, x, y,
							+(cell.getAttribute('dx') || '0'), +(cell.getAttribute('dy') || '0'));
					});
					return this;
				});
		}
	}
	
	interface ColorKey {
		src: string;
		base: string;
		transform: string;
	}
	
	export class Model {
		public name: string;
		public dir: string;
		public width: number;
		public height: number;
		public spritesheets: Spritesheet[];
		public spritemaps: Spritemap[];
		public sprites: Dict<Sprite> = {};
		public layers: Layer[]  = [];
		public palettes: Dict<Dict<string>>;
		public colorProps: string[]  = [];
		public readonly whenLoaded: Promise<Model>;
		public colorkeys: ColorKey[] = [];
		
		public putPixel(x: number, y: number, color: string) {
			let l = getSelSprite();
			if (!l) return;
			let ctx = l.ctx2d;
			if (!color) {
				ctx.clearRect(x, y, 1, 1);
			} else {
				ctx.fillStyle = color;
				ctx.fillRect(x, y, 1, 1);
			}
		}
		
		public isLoaded(): boolean {
			return this.spritesheets.every(s => s.isLoaded())
				   && this.spritemaps.every(s => s.isLoaded());
		}
		
		constructor(src: XMLDocument) {
			let xmodel        = $(src).children('model');
			this.name         = xmodel.attr('name');
			this.dir          = basedir + xmodel.attr('dir');
			this.width        = parseInt(xmodel.attr('width'));
			this.height       = parseInt(xmodel.attr('height'));
			this.spritesheets = [];
			this.spritemaps   = [];
			this.palettes     = {
				common: {}
			};
			
			xmodel.find('colorkeys>key').each((i, e) => {
				this.colorkeys.push({
					src      : e.getAttribute('src'),
					base     : e.getAttribute('base'),
					transform: e.getAttribute('transform') || ''
				});
			});
			
			//noinspection CssInvalidHtmlTagReference
			xmodel.find('palette>common>color').each((i, e) => {
				this.palettes.common[e.getAttribute('name')] = e.textContent;
				
			});
			xmodel.find('property').each((i, e) => {
				let cpname = e.getAttribute('name');
				this.colorProps.push(cpname);
				let p = this.palettes[cpname] = {};
				$(e).find('color').each((ci, ce) => {
					p[ce.getAttribute('name')] = ce.textContent;
				})
			});
			
			xmodel.find('spritesheet').each((i, x) => {
				let spritesheet = new Spritesheet(this.dir, x);
				this.spritesheets.push(spritesheet);
			});
			
			xmodel.find('spritemap').each((i, x) => {
				let spritemap = new Spritemap(this.dir, x);
				this.spritemaps.push(spritemap);
			});
			
			this.whenLoaded =
				Promise.all(this.spritesheets.map(p => p.whenLoaded as Promise<any>)
								.concat(this.spritemaps.map(p => p.whenLoaded as Promise<any>))
				).then(() => {
					for (let ss of this.spritesheets) {
						for (let sname in ss.sprites) {
							this.sprites[sname] = ss.sprites[sname];
						}
					}
					for (let sm of this.spritemaps) {
						for (let sname in sm.sprites) {
							this.sprites[sname] = sm.sprites[sname];
						}
					}
					xmodel.find('layer').each((i, x) => {
						let ln = x.getAttribute('file');
						let ldx = +(x.getAttribute('dx')||'0');
						let ldy = +(x.getAttribute('dy')||'0');
						this.layers.push(new Layer(ln,this.sprites[ln],ldx,ldy));
					});
					return this;
				});
		}
	}
	
	export let g_model: Model;
	export let g_composites: Composite[] = [];
	export let g_selsprite: string        = '';
	export let defaultLayerList          = [
		'eyes-human', 'hair0f', 'ears0', 'face0',
		'breasts0', 'arm0f', 'legs0', 'torso0', 'arm0b'
	];
	
	export function updateCompositeLayers(composite: Composite) {
		let j = composite.ui.find('.LayerBadges').html('');
		for (let l of composite.model.layers) {
			let b = $new('button.badge' +
						 (composite.isVisible(l.name) ? '.badge-primary' : '.badge-default'),
				l.name);
			b.click(() => {
				b.toggleClass('badge-primary');
				b.toggleClass('badge-default');
				composite.setVisible(l.name, !composite.isVisible(l.name));
				composite.redraw();
			});
			j.append(b, ' ');
		}
	}
	
	export function addCompositeView(layers: string[], zoom: number = 1): Composite {
		let composite = new Composite(g_model, layers, zoom);
		$('#ViewList').append(
			composite.ui = $new('.card.card-secondary.d-inline-flex',
				$new('.card-block',
					$new('h5.card-title',
						$new('button.ctrl.text-danger.pull-right', $new('span.fa.fa-close')
						).click(() => {
							removeCompositeView(composite);
						}),
						$new('button.ctrl', $new('span.fa.fa-search-plus')
						).click(() => {
							composite.zoom++;
						}),
						$new('button.ctrl', $new('span.fa.fa-search-minus')
						).click(() => {
							composite.zoom--;
						})
					),
					$new('div', $new('.canvas', composite.canvas)),
					$new('div',
						$new('label',
							$new('span.fa.fa-caret-down'), 'Layers'
						).click(e => {
							composite.ui.find('.LayerBadges').toggleClass('collapse');
						}),
						$new('.LayerBadges.collapse')
					),
					$new('div',
						$new('label',
							$new('span.fa.fa-caret-down'), 'Colors'
						).click(e => {
							composite.ui.find('.Colors').toggleClass('collapse');
						}),
						$new('.Colors.collapse',
							...g_model.colorProps.map(cpname =>
								$new('.row.control-group',
									$new('label.control-label.col-4', cpname),
									$new('select.form-control.col-8', ...
										[
											$new('option', '--none--'
											).attr('selected', 'true')
										].concat(
											paletteOptions(g_model.palettes['cpname'] || {}),
											paletteOptions(g_model.palettes['common']),
										)
									).change(e => {
										let s = e.target as HTMLSelectElement;
										if (s.value) {
											composite.colormap[cpname] = s.value;
										} else {
											delete composite.colormap[cpname];
										}
										composite.redraw();
									})
								)
							)
						)
					)
					/*$new('textarea.col.form-control'
					).val(layers.join(', ')
					).on('input change', e => {
						composite.layers = (e.target as HTMLTextAreaElement).value.split(/, *!/);
						composite.redraw();
					})*/
				)
			)
		);
		let drawing       = false;
		let dirty         = false;
		let x0            = g_model.width, y0 = g_model.height, x1 = -1, y1 = -1;
		let color: string = null;
		
		function putPixel(cx: number, cy: number) {
			let x = (cx / composite.zoom) | 0;
			let y = (cy / composite.zoom) | 0;
			dirty = true;
			g_model.putPixel(x, y, color);
			composite.redraw(x, y, 1, 1);
			if (x < x0) x0 = x;
			if (x > x1) x1 = x;
			if (y < y0) y0 = y;
			if (y > y1) y1 = y;
		}
		
		$(composite.canvas).mousedown(e => {
			let action    = $('[name=lmb-action]:checked').val();
			let keycolors = $('#lmb-color');
			switch (action) {
				case 'nothing':
					return;
				case 'erase':
					color = null;
					break;
				case 'keycolor':
					color = keycolors.val();
					break;
			}
			drawing = true;
			putPixel(e.offsetX, e.offsetY);
		}).mousemove(e => {
			if (drawing) {
				putPixel(e.offsetX, e.offsetY);
			}
		}).on('mouseup mouseout', e => {
			drawing = false;
			if (dirty) redrawAll(x0, y0, x1 - x0 + 1, y1 - y0 + 1);
			dirty = false;
		});
		g_composites.push(composite);
		updateCompositeLayers(composite);
		return composite;
	}
	
	export function removeCompositeView(composite: Composite) {
		let i = g_composites.indexOf(composite);
		if (i < 0) return;
		g_composites.splice(i, 1);
		composite.ui.remove();
	}
	
	export function redrawAll(x: number = 0,
							  y: number = 0,
							  w: number = g_model.width,
							  h: number = g_model.height) {
		for (let obj of g_composites) {
			obj.redraw(x, y, w, h);
		}
	}
	
	export function swapLayers(a: number, b: number) {
		let l0                = g_model.layers[a];
		g_model.layers[a] = g_model.layers[b];
		g_model.layers[b] = l0;
		showSpriteList(g_model);
		redrawAll();
	}
	
	function showSpriteList(model: Model) {
		let list = $('#LayerList');
		for (let sn in model.sprites) {
			let sprite = model.sprites[sn];
			if (sprite) sprite.ui.detach().appendTo(list);
		}
	}
	
	export function getSelSprite(): Sprite {
		return g_model.sprites[g_selsprite];
	}
	
	export function selSprite(name: string) {
		g_selsprite = name;
		$('#SelLayerName').html(name);
		$('.LayerListItem').removeClass('selected');
		let l = getSelSprite();
		if (l) {
			l.ui.addClass('selected');
			$('#SelLayerCanvas').html('').append(l.canvas);
		}
	}
	/*
	export function selLayerUp() {
		let i = g_model.layers.findIndex(layer=>layer.name==g_sellayer);
		if (i > 0) swapLayers(i, i - 1);
	}
	
	export function selLayerDown() {
		let i = g_model.layerNames.indexOf(g_sellayer);
		if (i >= 0 && i < g_model.layerNames.length - 1) swapLayers(i, i + 1);
	}
	*/
	export function colormap(src: ImageData, map: [number, number][]): ImageData {
		let dst  = new ImageData(src.width, src.height);
		let sarr = new Uint32Array(src.data.buffer);
		let darr = new Uint32Array(dst.data.buffer);
		for (let i = 0, n = darr.length; i < n; i++) {
			darr[i] = sarr[i];
			for (let j = 0, m = map.length; j < m; j++) {
				if (sarr[i] === map[j][0]) {
					darr[i] = map[j][1];
					break;
				}
			}
		}
		return dst;
	}
	
	function grabData(blob: Blob) {
		let mask    = $('#ClipboardMask').val();
		let i32mask = mask ? RGBA(tinycolor(mask)) : 0;
		url2img(URL.createObjectURL(blob)
		).then(img => {
			switch ($("input[name=clipboard-action]:checked").val()) {
				case 'replace':
					let layer = getSelSprite();
					if (!layer) return;
					layer.ctx2d.clearRect(0, 0, layer.width, layer.height);
					layer.ctx2d.drawImage(img, 0, 0);
					if (i32mask != 0) {
						let data = layer.ctx2d.getImageData(0, 0, layer.width, layer.height);
						data     = colormap(data, [[i32mask, 0]]);
						layer.ctx2d.clearRect(0, 0, layer.width, layer.height);
						layer.ctx2d.putImageData(data, 0, 0);
					}
					layer.updateUI();
					redrawAll();
					break;
			}
		});
	}
	
	export function loadModel(data: XMLDocument) {
		g_model = new Model(data);
		g_model.whenLoaded.then((model) => {
			console.log("Model = ", model);
			for (let ln in model.sprites) {
				let sprite = model.sprites[ln];
				if (!sprite) {
					console.warn("Non-existing sprite " + ln + " refered");
					continue;
				}
				sprite.ui = $new('div.LayerListItem',
					$new('label', ln),
					newCanvas(32, 32)
				).click(e => selSprite(ln));
				sprite.updateUI();
			}
			$('#SelLayerCanvas')
				.css('min-width', model.width + 'px')
				.css('min-height', model.height + 'px');
			$('#lmb-color').html('').append(
				model.colorkeys.map(ck =>
					$new('option', ck.base + (ck.transform ? ' ' + ck.transform : '')
					).attr('value', ck.src)
				)
			);
			showSpriteList(model);
			selSprite(Object.keys(model.sprites)[0]);
			addCompositeView(defaultLayerList, 3);
			addCompositeView(defaultLayerList, 2);
			addCompositeView(defaultLayerList, 1);
			addCompositeView(defaultLayerList, 1);
			$('#ClipboardGrabber').on('paste', e => {
				e.stopPropagation();
				e.preventDefault();
				let cd = (e.originalEvent as ClipboardEvent).clipboardData;
				for (let i = 0, n = cd.items.length; i < n; i++) {
					let item = cd.items[i];
					if (item.type.indexOf('image/') == 0) {
						grabData(item.getAsFile());
						return;
					} else {
						console.log('skip ' + item.kind + ' ' + item.type);
					}
				}
				alert("Please paste 1 image data or file");
			});
		});
	}
	
	$(() => {
		
		$.ajax(basedir + 'res/model.xml', {
			dataType: 'xml',
		}).then(loadModel
		).fail(err=>{
			console.log(err);
			$('#Loading').show();
			$('#ManualFile').change(e=>{
				let filesArray = (e.target as HTMLInputElement).files;
				for (let i=0;i<filesArray.length;i++) {
					let file = filesArray[i];
					if (file.name.indexOf('.xml')>=0) {
						let fr = new FileReader();
						fr.onload = ()=>loadModel($.parseXML(fr.result));
						fr.readAsText(file);
						$('#Loading').hide();
						return;
					}
				}
			});
		});
	});
}