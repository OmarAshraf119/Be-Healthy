import 'dart:collection' as prefix0;

class MyQueue<E extends Object> {
  List<E> Queue;
  MyQueue(){
    Queue = new List<E>();
  }
  MyQueue.fromList(List<E> clctn) {
  this.Queue = new List<E>();
  Queue = clctn;
  }
  List<E> getQueue() {
    return Queue;
  }
  E get(int i){
    return Queue.elementAt(i);
  }
  int indexOf(Object o){
    return Queue.indexOf(o);
  }
  E getElement(Object o){
    return Queue.elementAt((indexOf(o)));
  }
  int size(){
    return Queue.length;
  }
  set(int start,int end, Iterable<E> e){
    Queue.replaceRange(start, end,e);
  }
  E add(E e){
    if(Queue.length==7){ // Max Amount Of List Could Also Be An Array ......
      E x = Queue.elementAt(0) ;
      Queue.removeAt(0);
      Queue.add(e);
      return x;
    }
    else{
      Queue.add(e);
      return null;
    }
  }
   void clear(){
    Queue.clear();
  }
}