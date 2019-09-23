import random
import datetime
from urllib.parse import parse_qs
from django.utils import timezone
from django.http import JsonResponse
from colorbubbles.models import User

TIMEDELTA = datetime.timedelta(minutes= 1)

def set_color(request):
    query = parse_qs(request.META["QUERY_STRING"])
    id_ = query["id"][0]
    obj, created = User.objects.update_or_create(id=id_)
    obj.color = query["color"][0]
    obj.mod_date = timezone.now()
    if created:
        obj.pos_x = random.random()
        obj.pos_y = random.random()
    obj.save()
    return JsonResponse({'pos':[obj.pos_x, obj.pos_y]})

def get_colors(request):
    users = User.objects.all()
    now = timezone.now()

    if not users.exists(): #empty
        return JsonResponse({"users":[]})
    elems = []
    for user in users:
        if now - user.mod_date > TIMEDELTA:
            user.delete()
            continue
        elems.append({"id":user.id, "color": user.color,
                      "pos":[user.pos_x, user.pos_y]})
    return JsonResponse({"users":elems})