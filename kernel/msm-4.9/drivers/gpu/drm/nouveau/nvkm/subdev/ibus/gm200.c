/*
<<<<<<<< HEAD:kernel/msm-4.9/drivers/gpu/drm/nouveau/nvkm/subdev/ibus/gm200.c
 * Copyright 2015 Red Hat Inc.
========
 * Copyright 2016 Red Hat Inc.
>>>>>>>> WireOS:kernel/msm-4.9/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gp104.c
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
 * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
 * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 *
 * Authors: Ben Skeggs <bskeggs@redhat.com>
 */
<<<<<<<< HEAD:kernel/msm-4.9/drivers/gpu/drm/nouveau/nvkm/subdev/ibus/gm200.c
#include "priv.h"

static const struct nvkm_subdev_func
gm200_ibus = {
	.intr = gk104_ibus_intr,
};

int
gm200_ibus_new(struct nvkm_device *device, int index,
	       struct nvkm_subdev **pibus)
{
	struct nvkm_subdev *ibus;
	if (!(ibus = *pibus = kzalloc(sizeof(*ibus), GFP_KERNEL)))
		return -ENOMEM;
	nvkm_subdev_ctor(&gm200_ibus, device, index, ibus);
	return 0;
========
#include "gf100.h"
#include "ram.h"

#include <core/memory.h>

static const struct nvkm_fb_func
gp104_fb = {
	.dtor = gf100_fb_dtor,
	.oneinit = gf100_fb_oneinit,
	.init = gp100_fb_init,
	.init_page = gm200_fb_init_page,
	.ram_new = gp100_ram_new,
	.memtype_valid = gf100_fb_memtype_valid,
};

int
gp104_fb_new(struct nvkm_device *device, int index, struct nvkm_fb **pfb)
{
	return gf100_fb_new_(&gp104_fb, device, index, pfb);
>>>>>>>> WireOS:kernel/msm-4.9/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gp104.c
}
