Use
---

```javascript
group.onChildAdded.add(function (child, parent){
  // {child} was added to {parent}
});

group.onChildRemoved.add(function (child, prevParent){
  // {child} was removed from {prevParent}
});

group.onChildKilled.add(function (child, parent){
  // {child} was killed
});

group.onChildRevived.add(function (child, parent){
  // {child} was revived
});
```
