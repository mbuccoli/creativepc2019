from django.utils import timezone
from django.db import models


# Create your models here.
class User (models.Model):
    id = models.IntegerField(primary_key=True)
    pos_x = models.FloatField(default=0)
    pos_y = models.FloatField(default=0)
    color = models.CharField(max_length=200, default='')
    shape = models.CharField(max_length=200, default='')
    mod_date = models.DateTimeField(default=timezone.now)

    class Meta:
        ordering = ('mod_date',)

    def __str__(self):
        return str(self.id)