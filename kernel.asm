
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:
8010000c:	0f 20 e0             	mov    %cr4,%eax
8010000f:	83 c8 10             	or     $0x10,%eax
80100012:	0f 22 e0             	mov    %eax,%cr4
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc d0 75 11 80       	mov    $0x801175d0,%esp
8010002d:	b8 90 3c 10 80       	mov    $0x80103c90,%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb 54 b5 10 80       	mov    $0x8010b554,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 60 82 10 80       	push   $0x80108260
80100051:	68 20 b5 10 80       	push   $0x8010b520
80100056:	e8 c5 52 00 00       	call   80105320 <initlock>
  bcache.head.next = &bcache.head;
8010005b:	83 c4 10             	add    $0x10,%esp
8010005e:	b8 1c fc 10 80       	mov    $0x8010fc1c,%eax
  bcache.head.prev = &bcache.head;
80100063:	c7 05 6c fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc6c
8010006a:	fc 10 80 
  bcache.head.next = &bcache.head;
8010006d:	c7 05 70 fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc70
80100074:	fc 10 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 d3                	mov    %edx,%ebx
    b->next = bcache.head.next;
80100082:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100085:	83 ec 08             	sub    $0x8,%esp
80100088:	8d 43 0c             	lea    0xc(%ebx),%eax
    b->prev = &bcache.head;
8010008b:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 67 82 10 80       	push   $0x80108267
80100097:	50                   	push   %eax
80100098:	e8 53 51 00 00       	call   801051f0 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	81 fb c0 f9 10 80    	cmp    $0x8010f9c0,%ebx
801000bc:	75 c2                	jne    80100080 <binit+0x40>
  }
}
801000be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c1:	c9                   	leave  
801000c2:	c3                   	ret    
801000c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 20 b5 10 80       	push   $0x8010b520
801000e4:	e8 07 54 00 00       	call   801054f0 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 70 fc 10 80    	mov    0x8010fc70,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010011f:	90                   	nop
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 6c fc 10 80    	mov    0x8010fc6c,%ebx
80100126:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 6e                	jmp    8010019e <bread+0xce>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100139:	74 63                	je     8010019e <bread+0xce>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 20 b5 10 80       	push   $0x8010b520
80100162:	e8 29 53 00 00       	call   80105490 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 be 50 00 00       	call   80105230 <acquiresleep>
      return b;
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	74 0e                	je     80100188 <bread+0xb8>
    iderw(b);
  }
  return b;
}
8010017a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010017d:	89 d8                	mov    %ebx,%eax
8010017f:	5b                   	pop    %ebx
80100180:	5e                   	pop    %esi
80100181:	5f                   	pop    %edi
80100182:	5d                   	pop    %ebp
80100183:	c3                   	ret    
80100184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iderw(b);
80100188:	83 ec 0c             	sub    $0xc,%esp
8010018b:	53                   	push   %ebx
8010018c:	e8 7f 2d 00 00       	call   80102f10 <iderw>
80100191:	83 c4 10             	add    $0x10,%esp
}
80100194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100197:	89 d8                	mov    %ebx,%eax
80100199:	5b                   	pop    %ebx
8010019a:	5e                   	pop    %esi
8010019b:	5f                   	pop    %edi
8010019c:	5d                   	pop    %ebp
8010019d:	c3                   	ret    
  panic("bget: no buffers");
8010019e:	83 ec 0c             	sub    $0xc,%esp
801001a1:	68 6e 82 10 80       	push   $0x8010826e
801001a6:	e8 d5 01 00 00       	call   80100380 <panic>
801001ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801001af:	90                   	nop

801001b0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001b0:	55                   	push   %ebp
801001b1:	89 e5                	mov    %esp,%ebp
801001b3:	53                   	push   %ebx
801001b4:	83 ec 10             	sub    $0x10,%esp
801001b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001ba:	8d 43 0c             	lea    0xc(%ebx),%eax
801001bd:	50                   	push   %eax
801001be:	e8 0d 51 00 00       	call   801052d0 <holdingsleep>
801001c3:	83 c4 10             	add    $0x10,%esp
801001c6:	85 c0                	test   %eax,%eax
801001c8:	74 0f                	je     801001d9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ca:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001cd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001d3:	c9                   	leave  
  iderw(b);
801001d4:	e9 37 2d 00 00       	jmp    80102f10 <iderw>
    panic("bwrite");
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 7f 82 10 80       	push   $0x8010827f
801001e1:	e8 9a 01 00 00       	call   80100380 <panic>
801001e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801001ed:	8d 76 00             	lea    0x0(%esi),%esi

801001f0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001f0:	55                   	push   %ebp
801001f1:	89 e5                	mov    %esp,%ebp
801001f3:	56                   	push   %esi
801001f4:	53                   	push   %ebx
801001f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001f8:	8d 73 0c             	lea    0xc(%ebx),%esi
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 cc 50 00 00       	call   801052d0 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 66                	je     80100271 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 7c 50 00 00       	call   80105290 <releasesleep>

  acquire(&bcache.lock);
80100214:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010021b:	e8 d0 52 00 00       	call   801054f0 <acquire>
  b->refcnt--;
80100220:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100223:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100226:	83 e8 01             	sub    $0x1,%eax
80100229:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010022c:	85 c0                	test   %eax,%eax
8010022e:	75 2f                	jne    8010025f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100230:	8b 43 54             	mov    0x54(%ebx),%eax
80100233:	8b 53 50             	mov    0x50(%ebx),%edx
80100236:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100239:	8b 43 50             	mov    0x50(%ebx),%eax
8010023c:	8b 53 54             	mov    0x54(%ebx),%edx
8010023f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100242:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
    b->prev = &bcache.head;
80100247:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
    b->next = bcache.head.next;
8010024e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100251:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
80100256:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100259:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
  }
  
  release(&bcache.lock);
8010025f:	c7 45 08 20 b5 10 80 	movl   $0x8010b520,0x8(%ebp)
}
80100266:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100269:	5b                   	pop    %ebx
8010026a:	5e                   	pop    %esi
8010026b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010026c:	e9 1f 52 00 00       	jmp    80105490 <release>
    panic("brelse");
80100271:	83 ec 0c             	sub    $0xc,%esp
80100274:	68 86 82 10 80       	push   $0x80108286
80100279:	e8 02 01 00 00       	call   80100380 <panic>
8010027e:	66 90                	xchg   %ax,%ax

80100280 <consoleread>:

/*Q3 changes send here */

int
consoleread(struct inode *ip, char *dst, int n)
{
80100280:	55                   	push   %ebp
80100281:	89 e5                	mov    %esp,%ebp
80100283:	57                   	push   %edi
80100284:	56                   	push   %esi
80100285:	53                   	push   %ebx
80100286:	83 ec 18             	sub    $0x18,%esp
80100289:	8b 5d 10             	mov    0x10(%ebp),%ebx
8010028c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010028f:	ff 75 08             	push   0x8(%ebp)
  target = n;
80100292:	89 df                	mov    %ebx,%edi
  iunlock(ip);
80100294:	e8 f7 21 00 00       	call   80102490 <iunlock>
  acquire(&cons.lock);
80100299:	c7 04 24 20 09 11 80 	movl   $0x80110920,(%esp)
801002a0:	e8 4b 52 00 00       	call   801054f0 <acquire>
  while(n > 0){
801002a5:	83 c4 10             	add    $0x10,%esp
801002a8:	85 db                	test   %ebx,%ebx
801002aa:	0f 8e 94 00 00 00    	jle    80100344 <consoleread+0xc4>
    while(input.r == input.w){
801002b0:	a1 00 09 11 80       	mov    0x80110900,%eax
801002b5:	3b 05 04 09 11 80    	cmp    0x80110904,%eax
801002bb:	74 25                	je     801002e2 <consoleread+0x62>
801002bd:	eb 59                	jmp    80100318 <consoleread+0x98>
801002bf:	90                   	nop
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002c0:	83 ec 08             	sub    $0x8,%esp
801002c3:	68 20 09 11 80       	push   $0x80110920
801002c8:	68 00 09 11 80       	push   $0x80110900
801002cd:	e8 7e 4b 00 00       	call   80104e50 <sleep>
    while(input.r == input.w){
801002d2:	a1 00 09 11 80       	mov    0x80110900,%eax
801002d7:	83 c4 10             	add    $0x10,%esp
801002da:	3b 05 04 09 11 80    	cmp    0x80110904,%eax
801002e0:	75 36                	jne    80100318 <consoleread+0x98>
      if(myproc()->killed){
801002e2:	e8 f9 42 00 00       	call   801045e0 <myproc>
801002e7:	8b 48 24             	mov    0x24(%eax),%ecx
801002ea:	85 c9                	test   %ecx,%ecx
801002ec:	74 d2                	je     801002c0 <consoleread+0x40>
        release(&cons.lock);
801002ee:	83 ec 0c             	sub    $0xc,%esp
801002f1:	68 20 09 11 80       	push   $0x80110920
801002f6:	e8 95 51 00 00       	call   80105490 <release>
        ilock(ip);
801002fb:	5a                   	pop    %edx
801002fc:	ff 75 08             	push   0x8(%ebp)
801002ff:	e8 ac 20 00 00       	call   801023b0 <ilock>
        return -1;
80100304:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
80100307:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
8010030a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010030f:	5b                   	pop    %ebx
80100310:	5e                   	pop    %esi
80100311:	5f                   	pop    %edi
80100312:	5d                   	pop    %ebp
80100313:	c3                   	ret    
80100314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100318:	8d 50 01             	lea    0x1(%eax),%edx
8010031b:	89 15 00 09 11 80    	mov    %edx,0x80110900
80100321:	89 c2                	mov    %eax,%edx
80100323:	83 e2 7f             	and    $0x7f,%edx
80100326:	0f be 8a 80 08 11 80 	movsbl -0x7feef780(%edx),%ecx
    if(c == C('D')){  // EOF
8010032d:	80 f9 04             	cmp    $0x4,%cl
80100330:	74 37                	je     80100369 <consoleread+0xe9>
    *dst++ = c;
80100332:	83 c6 01             	add    $0x1,%esi
    --n;
80100335:	83 eb 01             	sub    $0x1,%ebx
    *dst++ = c;
80100338:	88 4e ff             	mov    %cl,-0x1(%esi)
    if(c == '\n')
8010033b:	83 f9 0a             	cmp    $0xa,%ecx
8010033e:	0f 85 64 ff ff ff    	jne    801002a8 <consoleread+0x28>
  release(&cons.lock);
80100344:	83 ec 0c             	sub    $0xc,%esp
80100347:	68 20 09 11 80       	push   $0x80110920
8010034c:	e8 3f 51 00 00       	call   80105490 <release>
  ilock(ip);
80100351:	58                   	pop    %eax
80100352:	ff 75 08             	push   0x8(%ebp)
80100355:	e8 56 20 00 00       	call   801023b0 <ilock>
  return target - n;
8010035a:	89 f8                	mov    %edi,%eax
8010035c:	83 c4 10             	add    $0x10,%esp
}
8010035f:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return target - n;
80100362:	29 d8                	sub    %ebx,%eax
}
80100364:	5b                   	pop    %ebx
80100365:	5e                   	pop    %esi
80100366:	5f                   	pop    %edi
80100367:	5d                   	pop    %ebp
80100368:	c3                   	ret    
      if(n < target){
80100369:	39 fb                	cmp    %edi,%ebx
8010036b:	73 d7                	jae    80100344 <consoleread+0xc4>
        input.r--;
8010036d:	a3 00 09 11 80       	mov    %eax,0x80110900
80100372:	eb d0                	jmp    80100344 <consoleread+0xc4>
80100374:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010037b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010037f:	90                   	nop

80100380 <panic>:
{
80100380:	55                   	push   %ebp
80100381:	89 e5                	mov    %esp,%ebp
80100383:	56                   	push   %esi
80100384:	53                   	push   %ebx
80100385:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100388:	fa                   	cli    
  cons.locking = 0;
80100389:	c7 05 54 09 11 80 00 	movl   $0x0,0x80110954
80100390:	00 00 00 
  getcallerpcs(&s, pcs);
80100393:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100396:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
80100399:	e8 82 31 00 00       	call   80103520 <lapicid>
8010039e:	83 ec 08             	sub    $0x8,%esp
801003a1:	50                   	push   %eax
801003a2:	68 8d 82 10 80       	push   $0x8010828d
801003a7:	e8 e4 03 00 00       	call   80100790 <cprintf>
  cprintf(s);
801003ac:	58                   	pop    %eax
801003ad:	ff 75 08             	push   0x8(%ebp)
801003b0:	e8 db 03 00 00       	call   80100790 <cprintf>
  cprintf("\n");
801003b5:	c7 04 24 c3 8d 10 80 	movl   $0x80108dc3,(%esp)
801003bc:	e8 cf 03 00 00       	call   80100790 <cprintf>
  getcallerpcs(&s, pcs);
801003c1:	8d 45 08             	lea    0x8(%ebp),%eax
801003c4:	5a                   	pop    %edx
801003c5:	59                   	pop    %ecx
801003c6:	53                   	push   %ebx
801003c7:	50                   	push   %eax
801003c8:	e8 73 4f 00 00       	call   80105340 <getcallerpcs>
  for(i=0; i<10; i++)
801003cd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003d0:	83 ec 08             	sub    $0x8,%esp
801003d3:	ff 33                	push   (%ebx)
  for(i=0; i<10; i++)
801003d5:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
801003d8:	68 a1 82 10 80       	push   $0x801082a1
801003dd:	e8 ae 03 00 00       	call   80100790 <cprintf>
  for(i=0; i<10; i++)
801003e2:	83 c4 10             	add    $0x10,%esp
801003e5:	39 f3                	cmp    %esi,%ebx
801003e7:	75 e7                	jne    801003d0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003e9:	c7 05 58 09 11 80 01 	movl   $0x1,0x80110958
801003f0:	00 00 00 
  for(;;)
801003f3:	eb fe                	jmp    801003f3 <panic+0x73>
801003f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801003fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100400 <cgaputc>:
{
80100400:	55                   	push   %ebp
80100401:	89 e5                	mov    %esp,%ebp
80100403:	57                   	push   %edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100404:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100409:	56                   	push   %esi
8010040a:	89 c6                	mov    %eax,%esi
8010040c:	b8 0e 00 00 00       	mov    $0xe,%eax
80100411:	53                   	push   %ebx
80100412:	83 ec 1c             	sub    $0x1c,%esp
80100415:	89 55 dc             	mov    %edx,-0x24(%ebp)
80100418:	89 fa                	mov    %edi,%edx
8010041a:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010041b:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80100420:	89 da                	mov    %ebx,%edx
80100422:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100423:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100426:	89 fa                	mov    %edi,%edx
80100428:	b8 0f 00 00 00       	mov    $0xf,%eax
8010042d:	c1 e1 08             	shl    $0x8,%ecx
80100430:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100431:	89 da                	mov    %ebx,%edx
80100433:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100434:	0f b6 d8             	movzbl %al,%ebx
80100437:	09 cb                	or     %ecx,%ebx
  switch(c) {
80100439:	81 fe e5 00 00 00    	cmp    $0xe5,%esi
8010043f:	74 26                	je     80100467 <cgaputc+0x67>
80100441:	0f 8f 99 00 00 00    	jg     801004e0 <cgaputc+0xe0>
80100447:	83 fe 0a             	cmp    $0xa,%esi
8010044a:	0f 84 10 01 00 00    	je     80100560 <cgaputc+0x160>
80100450:	81 fe e4 00 00 00    	cmp    $0xe4,%esi
80100456:	0f 85 90 00 00 00    	jne    801004ec <cgaputc+0xec>
      if(pos > 0) --pos;
8010045c:	85 db                	test   %ebx,%ebx
8010045e:	0f 84 ec 00 00 00    	je     80100550 <cgaputc+0x150>
80100464:	83 eb 01             	sub    $0x1,%ebx
  if(pos < 0 || pos > 25*80)
80100467:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
8010046d:	0f 8f 07 01 00 00    	jg     8010057a <cgaputc+0x17a>
  if((pos/80) >= 24){  // Scroll up.
80100473:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
80100479:	0f 8f 89 00 00 00    	jg     80100508 <cgaputc+0x108>
  outb(CRTPORT+1, pos>>8);
8010047f:	0f b6 c7             	movzbl %bh,%eax
  outb(CRTPORT+1, pos);
80100482:	88 5d e7             	mov    %bl,-0x19(%ebp)
  outb(CRTPORT+1, pos>>8);
80100485:	89 45 e0             	mov    %eax,-0x20(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100488:	bf d4 03 00 00       	mov    $0x3d4,%edi
8010048d:	b8 0e 00 00 00       	mov    $0xe,%eax
80100492:	89 fa                	mov    %edi,%edx
80100494:	ee                   	out    %al,(%dx)
80100495:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
8010049a:	0f b6 45 e0          	movzbl -0x20(%ebp),%eax
8010049e:	89 ca                	mov    %ecx,%edx
801004a0:	ee                   	out    %al,(%dx)
801004a1:	b8 0f 00 00 00       	mov    $0xf,%eax
801004a6:	89 fa                	mov    %edi,%edx
801004a8:	ee                   	out    %al,(%dx)
801004a9:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
801004ad:	89 ca                	mov    %ecx,%edx
801004af:	ee                   	out    %al,(%dx)
  if (c != LEFT_ARROW && c != RIGHT_ARROW && flag != 1) crt[pos] = ' ' | 0x0700;
801004b0:	81 ee e4 00 00 00    	sub    $0xe4,%esi
801004b6:	83 fe 01             	cmp    $0x1,%esi
801004b9:	76 13                	jbe    801004ce <cgaputc+0xce>
801004bb:	f6 45 dc 01          	testb  $0x1,-0x24(%ebp)
801004bf:	75 0d                	jne    801004ce <cgaputc+0xce>
801004c1:	b8 20 07 00 00       	mov    $0x720,%eax
801004c6:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
801004cd:	80 
}
801004ce:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004d1:	5b                   	pop    %ebx
801004d2:	5e                   	pop    %esi
801004d3:	5f                   	pop    %edi
801004d4:	5d                   	pop    %ebp
801004d5:	c3                   	ret    
801004d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801004dd:	8d 76 00             	lea    0x0(%esi),%esi
  switch(c) {
801004e0:	81 fe 00 01 00 00    	cmp    $0x100,%esi
801004e6:	0f 84 70 ff ff ff    	je     8010045c <cgaputc+0x5c>
      crt[pos++] = (c&0xff) | 0x0700;  // black on white
801004ec:	89 f0                	mov    %esi,%eax
801004ee:	0f b6 c0             	movzbl %al,%eax
801004f1:	80 cc 07             	or     $0x7,%ah
801004f4:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
801004fb:	80 
801004fc:	83 c3 01             	add    $0x1,%ebx
801004ff:	e9 63 ff ff ff       	jmp    80100467 <cgaputc+0x67>
80100504:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100508:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
8010050b:	83 eb 50             	sub    $0x50,%ebx
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010050e:	68 60 0e 00 00       	push   $0xe60
80100513:	68 a0 80 0b 80       	push   $0x800b80a0
80100518:	68 00 80 0b 80       	push   $0x800b8000
8010051d:	e8 2e 51 00 00       	call   80105650 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100522:	b8 80 07 00 00       	mov    $0x780,%eax
80100527:	83 c4 0c             	add    $0xc,%esp
8010052a:	29 d8                	sub    %ebx,%eax
8010052c:	01 c0                	add    %eax,%eax
8010052e:	50                   	push   %eax
8010052f:	8d 84 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%eax
80100536:	6a 00                	push   $0x0
80100538:	50                   	push   %eax
80100539:	e8 72 50 00 00       	call   801055b0 <memset>
  outb(CRTPORT+1, pos);
8010053e:	88 5d e7             	mov    %bl,-0x19(%ebp)
80100541:	83 c4 10             	add    $0x10,%esp
80100544:	c6 45 e0 07          	movb   $0x7,-0x20(%ebp)
80100548:	e9 3b ff ff ff       	jmp    80100488 <cgaputc+0x88>
8010054d:	8d 76 00             	lea    0x0(%esi),%esi
80100550:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
80100554:	c6 45 e0 00          	movb   $0x0,-0x20(%ebp)
80100558:	e9 2b ff ff ff       	jmp    80100488 <cgaputc+0x88>
8010055d:	8d 76 00             	lea    0x0(%esi),%esi
      pos += 80 - pos%80;
80100560:	89 d8                	mov    %ebx,%eax
80100562:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
80100567:	f7 e2                	mul    %edx
80100569:	c1 ea 06             	shr    $0x6,%edx
8010056c:	8d 04 92             	lea    (%edx,%edx,4),%eax
8010056f:	c1 e0 04             	shl    $0x4,%eax
80100572:	8d 58 50             	lea    0x50(%eax),%ebx
      break;
80100575:	e9 ed fe ff ff       	jmp    80100467 <cgaputc+0x67>
    panic("pos under/overflow");
8010057a:	83 ec 0c             	sub    $0xc,%esp
8010057d:	68 a5 82 10 80       	push   $0x801082a5
80100582:	e8 f9 fd ff ff       	call   80100380 <panic>
80100587:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010058e:	66 90                	xchg   %ax,%ax

80100590 <consputc.part.0>:
consputc(int c)
80100590:	55                   	push   %ebp
80100591:	89 e5                	mov    %esp,%ebp
80100593:	53                   	push   %ebx
80100594:	83 ec 04             	sub    $0x4,%esp
  switch (c) {
80100597:	3d e5 00 00 00       	cmp    $0xe5,%eax
8010059c:	0f 84 86 00 00 00    	je     80100628 <consputc.part.0+0x98>
801005a2:	89 c3                	mov    %eax,%ebx
801005a4:	3d 00 01 00 00       	cmp    $0x100,%eax
801005a9:	74 45                	je     801005f0 <consputc.part.0+0x60>
801005ab:	3d e4 00 00 00       	cmp    $0xe4,%eax
801005b0:	74 1e                	je     801005d0 <consputc.part.0+0x40>
      uartputc(c);
801005b2:	83 ec 0c             	sub    $0xc,%esp
801005b5:	50                   	push   %eax
801005b6:	e8 c5 67 00 00       	call   80106d80 <uartputc>
  if (c != RIGHT_ARROW) cgaputc(c, 0);
801005bb:	83 c4 10             	add    $0x10,%esp
801005be:	89 d8                	mov    %ebx,%eax
}
801005c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801005c3:	c9                   	leave  
  if (c != RIGHT_ARROW) cgaputc(c, 0);
801005c4:	31 d2                	xor    %edx,%edx
801005c6:	e9 35 fe ff ff       	jmp    80100400 <cgaputc>
801005cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801005cf:	90                   	nop
      uartputc('\b');
801005d0:	83 ec 0c             	sub    $0xc,%esp
801005d3:	6a 08                	push   $0x8
801005d5:	e8 a6 67 00 00       	call   80106d80 <uartputc>
      break;
801005da:	83 c4 10             	add    $0x10,%esp
  if (c != RIGHT_ARROW) cgaputc(c, 0);
801005dd:	89 d8                	mov    %ebx,%eax
}
801005df:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801005e2:	c9                   	leave  
  if (c != RIGHT_ARROW) cgaputc(c, 0);
801005e3:	31 d2                	xor    %edx,%edx
801005e5:	e9 16 fe ff ff       	jmp    80100400 <cgaputc>
801005ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      uartputc('\b'); uartputc(' '); uartputc('\b');  // uart is writing to the linux shell
801005f0:	83 ec 0c             	sub    $0xc,%esp
801005f3:	6a 08                	push   $0x8
801005f5:	e8 86 67 00 00       	call   80106d80 <uartputc>
801005fa:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100601:	e8 7a 67 00 00       	call   80106d80 <uartputc>
80100606:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010060d:	e8 6e 67 00 00       	call   80106d80 <uartputc>
      break;
80100612:	83 c4 10             	add    $0x10,%esp
  if (c != RIGHT_ARROW) cgaputc(c, 0);
80100615:	89 d8                	mov    %ebx,%eax
}
80100617:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010061a:	c9                   	leave  
  if (c != RIGHT_ARROW) cgaputc(c, 0);
8010061b:	31 d2                	xor    %edx,%edx
8010061d:	e9 de fd ff ff       	jmp    80100400 <cgaputc>
80100622:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if (input.e < input.rightmost) {
80100628:	a1 08 09 11 80       	mov    0x80110908,%eax
8010062d:	3b 05 0c 09 11 80    	cmp    0x8011090c,%eax
80100633:	72 0b                	jb     80100640 <consputc.part.0+0xb0>
}
80100635:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100638:	c9                   	leave  
80100639:	c3                   	ret    
8010063a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        uartputc(input.buf[input.e % INPUT_BUF]);
80100640:	83 e0 7f             	and    $0x7f,%eax
80100643:	83 ec 0c             	sub    $0xc,%esp
80100646:	0f be 80 80 08 11 80 	movsbl -0x7feef780(%eax),%eax
8010064d:	50                   	push   %eax
8010064e:	e8 2d 67 00 00       	call   80106d80 <uartputc>
        cgaputc(input.buf[input.e % INPUT_BUF], 1);
80100653:	a1 08 09 11 80       	mov    0x80110908,%eax
80100658:	ba 01 00 00 00       	mov    $0x1,%edx
8010065d:	83 e0 7f             	and    $0x7f,%eax
80100660:	0f be 80 80 08 11 80 	movsbl -0x7feef780(%eax),%eax
80100667:	e8 94 fd ff ff       	call   80100400 <cgaputc>
        input.e++;
8010066c:	83 05 08 09 11 80 01 	addl   $0x1,0x80110908
80100673:	83 c4 10             	add    $0x10,%esp
80100676:	eb bd                	jmp    80100635 <consputc.part.0+0xa5>
80100678:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010067f:	90                   	nop

80100680 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100680:	55                   	push   %ebp
80100681:	89 e5                	mov    %esp,%ebp
80100683:	57                   	push   %edi
80100684:	56                   	push   %esi
80100685:	53                   	push   %ebx
80100686:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
80100689:	ff 75 08             	push   0x8(%ebp)
{
8010068c:	8b 75 10             	mov    0x10(%ebp),%esi
  iunlock(ip);
8010068f:	e8 fc 1d 00 00       	call   80102490 <iunlock>
  acquire(&cons.lock);
80100694:	c7 04 24 20 09 11 80 	movl   $0x80110920,(%esp)
8010069b:	e8 50 4e 00 00       	call   801054f0 <acquire>
  for(i = 0; i < n; i++)
801006a0:	83 c4 10             	add    $0x10,%esp
801006a3:	85 f6                	test   %esi,%esi
801006a5:	7e 25                	jle    801006cc <consolewrite+0x4c>
801006a7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801006aa:	8d 3c 33             	lea    (%ebx,%esi,1),%edi
  if(panicked){
801006ad:	8b 15 58 09 11 80    	mov    0x80110958,%edx
    consputc(buf[i] & 0xff);
801006b3:	0f b6 03             	movzbl (%ebx),%eax
  if(panicked){
801006b6:	85 d2                	test   %edx,%edx
801006b8:	74 06                	je     801006c0 <consolewrite+0x40>
  asm volatile("cli");
801006ba:	fa                   	cli    
    for(;;)
801006bb:	eb fe                	jmp    801006bb <consolewrite+0x3b>
801006bd:	8d 76 00             	lea    0x0(%esi),%esi
801006c0:	e8 cb fe ff ff       	call   80100590 <consputc.part.0>
  for(i = 0; i < n; i++)
801006c5:	83 c3 01             	add    $0x1,%ebx
801006c8:	39 df                	cmp    %ebx,%edi
801006ca:	75 e1                	jne    801006ad <consolewrite+0x2d>
  release(&cons.lock);
801006cc:	83 ec 0c             	sub    $0xc,%esp
801006cf:	68 20 09 11 80       	push   $0x80110920
801006d4:	e8 b7 4d 00 00       	call   80105490 <release>
  ilock(ip);
801006d9:	58                   	pop    %eax
801006da:	ff 75 08             	push   0x8(%ebp)
801006dd:	e8 ce 1c 00 00       	call   801023b0 <ilock>

  return n;
}
801006e2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801006e5:	89 f0                	mov    %esi,%eax
801006e7:	5b                   	pop    %ebx
801006e8:	5e                   	pop    %esi
801006e9:	5f                   	pop    %edi
801006ea:	5d                   	pop    %ebp
801006eb:	c3                   	ret    
801006ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801006f0 <printint>:
{
801006f0:	55                   	push   %ebp
801006f1:	89 e5                	mov    %esp,%ebp
801006f3:	57                   	push   %edi
801006f4:	56                   	push   %esi
801006f5:	53                   	push   %ebx
801006f6:	83 ec 2c             	sub    $0x2c,%esp
801006f9:	89 55 d4             	mov    %edx,-0x2c(%ebp)
801006fc:	89 4d d0             	mov    %ecx,-0x30(%ebp)
  if(sign && (sign = xx < 0))
801006ff:	85 c9                	test   %ecx,%ecx
80100701:	74 04                	je     80100707 <printint+0x17>
80100703:	85 c0                	test   %eax,%eax
80100705:	78 6d                	js     80100774 <printint+0x84>
    x = xx;
80100707:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
8010070e:	89 c1                	mov    %eax,%ecx
  i = 0;
80100710:	31 db                	xor    %ebx,%ebx
80100712:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    buf[i++] = digits[x % base];
80100718:	89 c8                	mov    %ecx,%eax
8010071a:	31 d2                	xor    %edx,%edx
8010071c:	89 de                	mov    %ebx,%esi
8010071e:	89 cf                	mov    %ecx,%edi
80100720:	f7 75 d4             	divl   -0x2c(%ebp)
80100723:	8d 5b 01             	lea    0x1(%ebx),%ebx
80100726:	0f b6 92 d0 82 10 80 	movzbl -0x7fef7d30(%edx),%edx
  }while((x /= base) != 0);
8010072d:	89 c1                	mov    %eax,%ecx
    buf[i++] = digits[x % base];
8010072f:	88 54 1d d7          	mov    %dl,-0x29(%ebp,%ebx,1)
  }while((x /= base) != 0);
80100733:	3b 7d d4             	cmp    -0x2c(%ebp),%edi
80100736:	73 e0                	jae    80100718 <printint+0x28>
  if(sign)
80100738:	8b 4d d0             	mov    -0x30(%ebp),%ecx
8010073b:	85 c9                	test   %ecx,%ecx
8010073d:	74 0c                	je     8010074b <printint+0x5b>
    buf[i++] = '-';
8010073f:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
80100744:	89 de                	mov    %ebx,%esi
    buf[i++] = '-';
80100746:	ba 2d 00 00 00       	mov    $0x2d,%edx
  while(--i >= 0)
8010074b:	8d 5c 35 d7          	lea    -0x29(%ebp,%esi,1),%ebx
8010074f:	0f be c2             	movsbl %dl,%eax
  if(panicked){
80100752:	8b 15 58 09 11 80    	mov    0x80110958,%edx
80100758:	85 d2                	test   %edx,%edx
8010075a:	74 04                	je     80100760 <printint+0x70>
8010075c:	fa                   	cli    
    for(;;)
8010075d:	eb fe                	jmp    8010075d <printint+0x6d>
8010075f:	90                   	nop
80100760:	e8 2b fe ff ff       	call   80100590 <consputc.part.0>
  while(--i >= 0)
80100765:	8d 45 d7             	lea    -0x29(%ebp),%eax
80100768:	39 c3                	cmp    %eax,%ebx
8010076a:	74 0e                	je     8010077a <printint+0x8a>
    consputc(buf[i]);
8010076c:	0f be 03             	movsbl (%ebx),%eax
8010076f:	83 eb 01             	sub    $0x1,%ebx
80100772:	eb de                	jmp    80100752 <printint+0x62>
    x = -xx;
80100774:	f7 d8                	neg    %eax
80100776:	89 c1                	mov    %eax,%ecx
80100778:	eb 96                	jmp    80100710 <printint+0x20>
}
8010077a:	83 c4 2c             	add    $0x2c,%esp
8010077d:	5b                   	pop    %ebx
8010077e:	5e                   	pop    %esi
8010077f:	5f                   	pop    %edi
80100780:	5d                   	pop    %ebp
80100781:	c3                   	ret    
80100782:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100790 <cprintf>:
{
80100790:	55                   	push   %ebp
80100791:	89 e5                	mov    %esp,%ebp
80100793:	57                   	push   %edi
80100794:	56                   	push   %esi
80100795:	53                   	push   %ebx
80100796:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100799:	a1 54 09 11 80       	mov    0x80110954,%eax
8010079e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(locking)
801007a1:	85 c0                	test   %eax,%eax
801007a3:	0f 85 27 01 00 00    	jne    801008d0 <cprintf+0x140>
  if (fmt == 0)
801007a9:	8b 75 08             	mov    0x8(%ebp),%esi
801007ac:	85 f6                	test   %esi,%esi
801007ae:	0f 84 f0 01 00 00    	je     801009a4 <cprintf+0x214>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007b4:	0f b6 06             	movzbl (%esi),%eax
  argp = (uint*)(void*)(&fmt + 1);
801007b7:	8d 7d 0c             	lea    0xc(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007ba:	31 db                	xor    %ebx,%ebx
801007bc:	85 c0                	test   %eax,%eax
801007be:	74 56                	je     80100816 <cprintf+0x86>
    if(c != '%'){
801007c0:	83 f8 25             	cmp    $0x25,%eax
801007c3:	0f 85 cf 00 00 00    	jne    80100898 <cprintf+0x108>
    c = fmt[++i] & 0xff;
801007c9:	83 c3 01             	add    $0x1,%ebx
801007cc:	0f b6 0c 1e          	movzbl (%esi,%ebx,1),%ecx
    if(c == 0)
801007d0:	85 c9                	test   %ecx,%ecx
801007d2:	74 42                	je     80100816 <cprintf+0x86>
    switch(c){
801007d4:	83 f9 70             	cmp    $0x70,%ecx
801007d7:	0f 84 90 00 00 00    	je     8010086d <cprintf+0xdd>
801007dd:	7f 51                	jg     80100830 <cprintf+0xa0>
801007df:	83 f9 25             	cmp    $0x25,%ecx
801007e2:	0f 84 38 01 00 00    	je     80100920 <cprintf+0x190>
801007e8:	83 f9 64             	cmp    $0x64,%ecx
801007eb:	0f 85 f4 00 00 00    	jne    801008e5 <cprintf+0x155>
      printint(*argp++, 10, 1);
801007f1:	8d 47 04             	lea    0x4(%edi),%eax
801007f4:	b9 01 00 00 00       	mov    $0x1,%ecx
801007f9:	ba 0a 00 00 00       	mov    $0xa,%edx
801007fe:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100801:	8b 07                	mov    (%edi),%eax
80100803:	e8 e8 fe ff ff       	call   801006f0 <printint>
80100808:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010080b:	83 c3 01             	add    $0x1,%ebx
8010080e:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
80100812:	85 c0                	test   %eax,%eax
80100814:	75 aa                	jne    801007c0 <cprintf+0x30>
  if(locking)
80100816:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100819:	85 c0                	test   %eax,%eax
8010081b:	0f 85 66 01 00 00    	jne    80100987 <cprintf+0x1f7>
}
80100821:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100824:	5b                   	pop    %ebx
80100825:	5e                   	pop    %esi
80100826:	5f                   	pop    %edi
80100827:	5d                   	pop    %ebp
80100828:	c3                   	ret    
80100829:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100830:	83 f9 73             	cmp    $0x73,%ecx
80100833:	75 33                	jne    80100868 <cprintf+0xd8>
      if((s = (char*)*argp++) == 0)
80100835:	8d 47 04             	lea    0x4(%edi),%eax
80100838:	8b 3f                	mov    (%edi),%edi
8010083a:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010083d:	85 ff                	test   %edi,%edi
8010083f:	0f 84 33 01 00 00    	je     80100978 <cprintf+0x1e8>
      for(; *s; s++)
80100845:	0f be 07             	movsbl (%edi),%eax
80100848:	84 c0                	test   %al,%al
8010084a:	0f 84 4c 01 00 00    	je     8010099c <cprintf+0x20c>
  if(panicked){
80100850:	8b 15 58 09 11 80    	mov    0x80110958,%edx
80100856:	85 d2                	test   %edx,%edx
80100858:	0f 84 d2 00 00 00    	je     80100930 <cprintf+0x1a0>
8010085e:	fa                   	cli    
    for(;;)
8010085f:	eb fe                	jmp    8010085f <cprintf+0xcf>
80100861:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100868:	83 f9 78             	cmp    $0x78,%ecx
8010086b:	75 78                	jne    801008e5 <cprintf+0x155>
      printint(*argp++, 16, 0);
8010086d:	8d 47 04             	lea    0x4(%edi),%eax
80100870:	31 c9                	xor    %ecx,%ecx
80100872:	ba 10 00 00 00       	mov    $0x10,%edx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100877:	83 c3 01             	add    $0x1,%ebx
      printint(*argp++, 16, 0);
8010087a:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010087d:	8b 07                	mov    (%edi),%eax
8010087f:	e8 6c fe ff ff       	call   801006f0 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100884:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
      printint(*argp++, 16, 0);
80100888:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010088b:	85 c0                	test   %eax,%eax
8010088d:	0f 85 2d ff ff ff    	jne    801007c0 <cprintf+0x30>
80100893:	eb 81                	jmp    80100816 <cprintf+0x86>
80100895:	8d 76 00             	lea    0x0(%esi),%esi
  if(panicked){
80100898:	8b 0d 58 09 11 80    	mov    0x80110958,%ecx
8010089e:	85 c9                	test   %ecx,%ecx
801008a0:	74 0e                	je     801008b0 <cprintf+0x120>
801008a2:	fa                   	cli    
    for(;;)
801008a3:	eb fe                	jmp    801008a3 <cprintf+0x113>
801008a5:	8d 76 00             	lea    0x0(%esi),%esi
801008a8:	89 c8                	mov    %ecx,%eax
801008aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801008b0:	e8 db fc ff ff       	call   80100590 <consputc.part.0>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801008b5:	83 c3 01             	add    $0x1,%ebx
801008b8:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
801008bc:	85 c0                	test   %eax,%eax
801008be:	0f 85 fc fe ff ff    	jne    801007c0 <cprintf+0x30>
801008c4:	e9 4d ff ff ff       	jmp    80100816 <cprintf+0x86>
801008c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801008d0:	83 ec 0c             	sub    $0xc,%esp
801008d3:	68 20 09 11 80       	push   $0x80110920
801008d8:	e8 13 4c 00 00       	call   801054f0 <acquire>
801008dd:	83 c4 10             	add    $0x10,%esp
801008e0:	e9 c4 fe ff ff       	jmp    801007a9 <cprintf+0x19>
  if(panicked){
801008e5:	a1 58 09 11 80       	mov    0x80110958,%eax
801008ea:	85 c0                	test   %eax,%eax
801008ec:	0f 85 7e 00 00 00    	jne    80100970 <cprintf+0x1e0>
      uartputc(c);
801008f2:	83 ec 0c             	sub    $0xc,%esp
801008f5:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801008f8:	6a 25                	push   $0x25
801008fa:	e8 81 64 00 00       	call   80106d80 <uartputc>
  if (c != RIGHT_ARROW) cgaputc(c, 0);
801008ff:	31 d2                	xor    %edx,%edx
80100901:	b8 25 00 00 00       	mov    $0x25,%eax
80100906:	e8 f5 fa ff ff       	call   80100400 <cgaputc>
  if(panicked){
8010090b:	8b 15 58 09 11 80    	mov    0x80110958,%edx
80100911:	83 c4 10             	add    $0x10,%esp
80100914:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80100917:	85 d2                	test   %edx,%edx
80100919:	74 8d                	je     801008a8 <cprintf+0x118>
8010091b:	fa                   	cli    
    for(;;)
8010091c:	eb fe                	jmp    8010091c <cprintf+0x18c>
8010091e:	66 90                	xchg   %ax,%ax
  if(panicked){
80100920:	a1 58 09 11 80       	mov    0x80110958,%eax
80100925:	85 c0                	test   %eax,%eax
80100927:	74 14                	je     8010093d <cprintf+0x1ad>
80100929:	fa                   	cli    
    for(;;)
8010092a:	eb fe                	jmp    8010092a <cprintf+0x19a>
8010092c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100930:	e8 5b fc ff ff       	call   80100590 <consputc.part.0>
      for(; *s; s++)
80100935:	83 c7 01             	add    $0x1,%edi
80100938:	e9 08 ff ff ff       	jmp    80100845 <cprintf+0xb5>
      uartputc(c);
8010093d:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100940:	83 c3 01             	add    $0x1,%ebx
      uartputc(c);
80100943:	6a 25                	push   $0x25
80100945:	e8 36 64 00 00       	call   80106d80 <uartputc>
  if (c != RIGHT_ARROW) cgaputc(c, 0);
8010094a:	b8 25 00 00 00       	mov    $0x25,%eax
8010094f:	31 d2                	xor    %edx,%edx
80100951:	e8 aa fa ff ff       	call   80100400 <cgaputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100956:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
  if (c != RIGHT_ARROW) cgaputc(c, 0);
8010095a:	83 c4 10             	add    $0x10,%esp
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010095d:	85 c0                	test   %eax,%eax
8010095f:	0f 85 5b fe ff ff    	jne    801007c0 <cprintf+0x30>
80100965:	e9 ac fe ff ff       	jmp    80100816 <cprintf+0x86>
8010096a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100970:	fa                   	cli    
    for(;;)
80100971:	eb fe                	jmp    80100971 <cprintf+0x1e1>
80100973:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100977:	90                   	nop
        s = "(null)";
80100978:	bf b8 82 10 80       	mov    $0x801082b8,%edi
      for(; *s; s++)
8010097d:	b8 28 00 00 00       	mov    $0x28,%eax
80100982:	e9 c9 fe ff ff       	jmp    80100850 <cprintf+0xc0>
    release(&cons.lock);
80100987:	83 ec 0c             	sub    $0xc,%esp
8010098a:	68 20 09 11 80       	push   $0x80110920
8010098f:	e8 fc 4a 00 00       	call   80105490 <release>
80100994:	83 c4 10             	add    $0x10,%esp
}
80100997:	e9 85 fe ff ff       	jmp    80100821 <cprintf+0x91>
      if((s = (char*)*argp++) == 0)
8010099c:	8b 7d e0             	mov    -0x20(%ebp),%edi
8010099f:	e9 67 fe ff ff       	jmp    8010080b <cprintf+0x7b>
    panic("null fmt");
801009a4:	83 ec 0c             	sub    $0xc,%esp
801009a7:	68 bf 82 10 80       	push   $0x801082bf
801009ac:	e8 cf f9 ff ff       	call   80100380 <panic>
801009b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801009b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801009bf:	90                   	nop

801009c0 <copyCharsToBeMoved>:
  for (uint i = 0; i < (uint)(input.rightmost - input.r); i++) {
801009c0:	8b 0d 0c 09 11 80    	mov    0x8011090c,%ecx
801009c6:	2b 0d 00 09 11 80    	sub    0x80110900,%ecx
801009cc:	74 32                	je     80100a00 <copyCharsToBeMoved+0x40>
void copyCharsToBeMoved() {
801009ce:	55                   	push   %ebp
  for (uint i = 0; i < (uint)(input.rightmost - input.r); i++) {
801009cf:	31 c0                	xor    %eax,%eax
void copyCharsToBeMoved() {
801009d1:	89 e5                	mov    %esp,%ebp
801009d3:	53                   	push   %ebx
    charsToBeMoved[i] = input.buf[(input.e + i) % INPUT_BUF];
801009d4:	8b 1d 08 09 11 80    	mov    0x80110908,%ebx
801009da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801009e0:	8d 14 03             	lea    (%ebx,%eax,1),%edx
  for (uint i = 0; i < (uint)(input.rightmost - input.r); i++) {
801009e3:	83 c0 01             	add    $0x1,%eax
    charsToBeMoved[i] = input.buf[(input.e + i) % INPUT_BUF];
801009e6:	83 e2 7f             	and    $0x7f,%edx
801009e9:	0f b6 92 80 08 11 80 	movzbl -0x7feef780(%edx),%edx
801009f0:	88 90 ff 07 11 80    	mov    %dl,-0x7feef801(%eax)
  for (uint i = 0; i < (uint)(input.rightmost - input.r); i++) {
801009f6:	39 c8                	cmp    %ecx,%eax
801009f8:	75 e6                	jne    801009e0 <copyCharsToBeMoved+0x20>
}
801009fa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801009fd:	c9                   	leave  
801009fe:	c3                   	ret    
801009ff:	90                   	nop
80100a00:	c3                   	ret    
80100a01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100a08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100a0f:	90                   	nop

80100a10 <rightShiftBuffer>:
void rightShiftBuffer() {
80100a10:	55                   	push   %ebp
  uint n = input.rightmost - input.e;
80100a11:	a1 08 09 11 80       	mov    0x80110908,%eax
void rightShiftBuffer() {
80100a16:	89 e5                	mov    %esp,%ebp
80100a18:	56                   	push   %esi
80100a19:	53                   	push   %ebx
  for (uint i = 0; i < n; i++) {
80100a1a:	8b 1d 0c 09 11 80    	mov    0x8011090c,%ebx
80100a20:	29 c3                	sub    %eax,%ebx
80100a22:	74 3a                	je     80100a5e <rightShiftBuffer+0x4e>
80100a24:	31 f6                	xor    %esi,%esi
    input.buf[(input.e + i) % INPUT_BUF] = charsToBeMoved[i];
80100a26:	0f b6 96 00 08 11 80 	movzbl -0x7feef800(%esi),%edx
80100a2d:	01 f0                	add    %esi,%eax
  if(panicked){
80100a2f:	8b 0d 58 09 11 80    	mov    0x80110958,%ecx
    input.buf[(input.e + i) % INPUT_BUF] = charsToBeMoved[i];
80100a35:	83 e0 7f             	and    $0x7f,%eax
80100a38:	88 90 80 08 11 80    	mov    %dl,-0x7feef780(%eax)
  if(panicked){
80100a3e:	85 c9                	test   %ecx,%ecx
80100a40:	74 06                	je     80100a48 <rightShiftBuffer+0x38>
80100a42:	fa                   	cli    
    for(;;)
80100a43:	eb fe                	jmp    80100a43 <rightShiftBuffer+0x33>
80100a45:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(charsToBeMoved[i]);
80100a48:	0f be c2             	movsbl %dl,%eax
  for (uint i = 0; i < n; i++) {
80100a4b:	83 c6 01             	add    $0x1,%esi
80100a4e:	e8 3d fb ff ff       	call   80100590 <consputc.part.0>
80100a53:	39 f3                	cmp    %esi,%ebx
80100a55:	74 07                	je     80100a5e <rightShiftBuffer+0x4e>
    input.buf[(input.e + i) % INPUT_BUF] = charsToBeMoved[i];
80100a57:	a1 08 09 11 80       	mov    0x80110908,%eax
80100a5c:	eb c8                	jmp    80100a26 <rightShiftBuffer+0x16>
  for(uint i = 0; i < INPUT_BUF; i++) {
80100a5e:	31 c0                	xor    %eax,%eax
    charsToBeMoved[i] = '\0';
80100a60:	c6 80 00 08 11 80 00 	movb   $0x0,-0x7feef800(%eax)
  for(uint i = 0; i < INPUT_BUF; i++) {
80100a67:	83 c0 01             	add    $0x1,%eax
80100a6a:	3d 80 00 00 00       	cmp    $0x80,%eax
80100a6f:	75 ef                	jne    80100a60 <rightShiftBuffer+0x50>
  while (i--) {
80100a71:	85 db                	test   %ebx,%ebx
80100a73:	74 31                	je     80100aa6 <rightShiftBuffer+0x96>
  if(panicked){
80100a75:	a1 58 09 11 80       	mov    0x80110958,%eax
80100a7a:	85 c0                	test   %eax,%eax
80100a7c:	74 0a                	je     80100a88 <rightShiftBuffer+0x78>
80100a7e:	fa                   	cli    
    for(;;)
80100a7f:	eb fe                	jmp    80100a7f <rightShiftBuffer+0x6f>
80100a81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      uartputc('\b');
80100a88:	83 ec 0c             	sub    $0xc,%esp
80100a8b:	6a 08                	push   $0x8
80100a8d:	e8 ee 62 00 00       	call   80106d80 <uartputc>
  if (c != RIGHT_ARROW) cgaputc(c, 0);
80100a92:	31 d2                	xor    %edx,%edx
80100a94:	b8 e4 00 00 00       	mov    $0xe4,%eax
80100a99:	e8 62 f9 ff ff       	call   80100400 <cgaputc>
  while (i--) {
80100a9e:	83 c4 10             	add    $0x10,%esp
80100aa1:	83 eb 01             	sub    $0x1,%ebx
80100aa4:	75 cf                	jne    80100a75 <rightShiftBuffer+0x65>
}
80100aa6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100aa9:	5b                   	pop    %ebx
80100aaa:	5e                   	pop    %esi
80100aab:	5d                   	pop    %ebp
80100aac:	c3                   	ret    
80100aad:	8d 76 00             	lea    0x0(%esi),%esi

80100ab0 <leftShiftBuffer>:
void leftShiftBuffer() {
80100ab0:	55                   	push   %ebp
  uint n = input.rightmost - input.e;
80100ab1:	a1 08 09 11 80       	mov    0x80110908,%eax
void leftShiftBuffer() {
80100ab6:	89 e5                	mov    %esp,%ebp
80100ab8:	56                   	push   %esi
  if(panicked){
80100ab9:	8b 35 58 09 11 80    	mov    0x80110958,%esi
void leftShiftBuffer() {
80100abf:	53                   	push   %ebx
  uint n = input.rightmost - input.e;
80100ac0:	8b 1d 0c 09 11 80    	mov    0x8011090c,%ebx
  if(panicked){
80100ac6:	85 f6                	test   %esi,%esi
80100ac8:	74 06                	je     80100ad0 <leftShiftBuffer+0x20>
80100aca:	fa                   	cli    
    for(;;)
80100acb:	eb fe                	jmp    80100acb <leftShiftBuffer+0x1b>
80100acd:	8d 76 00             	lea    0x0(%esi),%esi
      uartputc('\b');
80100ad0:	83 ec 0c             	sub    $0xc,%esp
  uint n = input.rightmost - input.e;
80100ad3:	29 c3                	sub    %eax,%ebx
      uartputc('\b');
80100ad5:	6a 08                	push   $0x8
80100ad7:	e8 a4 62 00 00       	call   80106d80 <uartputc>
  if (c != RIGHT_ARROW) cgaputc(c, 0);
80100adc:	b8 e4 00 00 00       	mov    $0xe4,%eax
80100ae1:	31 d2                	xor    %edx,%edx
80100ae3:	e8 18 f9 ff ff       	call   80100400 <cgaputc>
  input.e--; // set the backend part of cursor to the final correct position
80100ae8:	a1 08 09 11 80       	mov    0x80110908,%eax
  for (uint i = 0; i < n; i++) {
80100aed:	83 c4 10             	add    $0x10,%esp
  input.e--; // set the backend part of cursor to the final correct position
80100af0:	83 e8 01             	sub    $0x1,%eax
80100af3:	a3 08 09 11 80       	mov    %eax,0x80110908
  for (uint i = 0; i < n; i++) {
80100af8:	85 db                	test   %ebx,%ebx
80100afa:	74 42                	je     80100b3e <leftShiftBuffer+0x8e>
80100afc:	31 f6                	xor    %esi,%esi
    input.buf[(input.e + i) % INPUT_BUF] = input.buf[(input.e + i + 1) % INPUT_BUF];
80100afe:	01 f0                	add    %esi,%eax
  if(panicked){
80100b00:	8b 0d 58 09 11 80    	mov    0x80110958,%ecx
    input.buf[(input.e + i) % INPUT_BUF] = input.buf[(input.e + i + 1) % INPUT_BUF];
80100b06:	8d 50 01             	lea    0x1(%eax),%edx
80100b09:	83 e0 7f             	and    $0x7f,%eax
80100b0c:	83 e2 7f             	and    $0x7f,%edx
80100b0f:	0f b6 92 80 08 11 80 	movzbl -0x7feef780(%edx),%edx
80100b16:	88 90 80 08 11 80    	mov    %dl,-0x7feef780(%eax)
  if(panicked){
80100b1c:	85 c9                	test   %ecx,%ecx
80100b1e:	74 08                	je     80100b28 <leftShiftBuffer+0x78>
80100b20:	fa                   	cli    
    for(;;)
80100b21:	eb fe                	jmp    80100b21 <leftShiftBuffer+0x71>
80100b23:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100b27:	90                   	nop
    consputc(input.buf[(input.e + i + 1) % INPUT_BUF]);
80100b28:	0f be c2             	movsbl %dl,%eax
  for (uint i = 0; i < n; i++) {
80100b2b:	83 c6 01             	add    $0x1,%esi
80100b2e:	e8 5d fa ff ff       	call   80100590 <consputc.part.0>
80100b33:	39 f3                	cmp    %esi,%ebx
80100b35:	74 49                	je     80100b80 <leftShiftBuffer+0xd0>
    input.buf[(input.e + i) % INPUT_BUF] = input.buf[(input.e + i + 1) % INPUT_BUF];
80100b37:	a1 08 09 11 80       	mov    0x80110908,%eax
80100b3c:	eb c0                	jmp    80100afe <leftShiftBuffer+0x4e>
  if(panicked){
80100b3e:	8b 1d 58 09 11 80    	mov    0x80110958,%ebx
  input.rightmost--; // set input.rightmost to the final correct position
80100b44:	83 2d 0c 09 11 80 01 	subl   $0x1,0x8011090c
  if(panicked){
80100b4b:	85 db                	test   %ebx,%ebx
80100b4d:	75 29                	jne    80100b78 <leftShiftBuffer+0xc8>
      uartputc(c);
80100b4f:	83 ec 0c             	sub    $0xc,%esp
80100b52:	6a 20                	push   $0x20
80100b54:	e8 27 62 00 00       	call   80106d80 <uartputc>
  if (c != RIGHT_ARROW) cgaputc(c, 0);
80100b59:	31 d2                	xor    %edx,%edx
80100b5b:	b8 20 00 00 00       	mov    $0x20,%eax
80100b60:	e8 9b f8 ff ff       	call   80100400 <cgaputc>
80100b65:	83 c4 10             	add    $0x10,%esp
  if(panicked){
80100b68:	a1 58 09 11 80       	mov    0x80110958,%eax
80100b6d:	85 c0                	test   %eax,%eax
80100b6f:	74 45                	je     80100bb6 <leftShiftBuffer+0x106>
80100b71:	fa                   	cli    
    for(;;)
80100b72:	eb fe                	jmp    80100b72 <leftShiftBuffer+0xc2>
80100b74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100b78:	fa                   	cli    
80100b79:	eb fe                	jmp    80100b79 <leftShiftBuffer+0xc9>
80100b7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100b7f:	90                   	nop
  if(panicked){
80100b80:	8b 15 58 09 11 80    	mov    0x80110958,%edx
  input.rightmost--; // set input.rightmost to the final correct position
80100b86:	83 2d 0c 09 11 80 01 	subl   $0x1,0x8011090c
  if(panicked){
80100b8d:	85 d2                	test   %edx,%edx
80100b8f:	75 e7                	jne    80100b78 <leftShiftBuffer+0xc8>
      uartputc(c);
80100b91:	83 ec 0c             	sub    $0xc,%esp
80100b94:	6a 20                	push   $0x20
80100b96:	e8 e5 61 00 00       	call   80106d80 <uartputc>
  if (c != RIGHT_ARROW) cgaputc(c, 0);
80100b9b:	31 d2                	xor    %edx,%edx
80100b9d:	b8 20 00 00 00       	mov    $0x20,%eax
80100ba2:	e8 59 f8 ff ff       	call   80100400 <cgaputc>
  while (i--){
80100ba7:	83 c4 10             	add    $0x10,%esp
80100baa:	83 fb ff             	cmp    $0xffffffff,%ebx
80100bad:	75 b9                	jne    80100b68 <leftShiftBuffer+0xb8>
}
80100baf:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100bb2:	5b                   	pop    %ebx
80100bb3:	5e                   	pop    %esi
80100bb4:	5d                   	pop    %ebp
80100bb5:	c3                   	ret    
      uartputc('\b');
80100bb6:	83 ec 0c             	sub    $0xc,%esp
  while (i--){
80100bb9:	83 eb 01             	sub    $0x1,%ebx
      uartputc('\b');
80100bbc:	6a 08                	push   $0x8
80100bbe:	e8 bd 61 00 00       	call   80106d80 <uartputc>
  if (c != RIGHT_ARROW) cgaputc(c, 0);
80100bc3:	31 d2                	xor    %edx,%edx
80100bc5:	b8 e4 00 00 00       	mov    $0xe4,%eax
80100bca:	e8 31 f8 ff ff       	call   80100400 <cgaputc>
  while (i--){
80100bcf:	83 c4 10             	add    $0x10,%esp
80100bd2:	83 fb ff             	cmp    $0xffffffff,%ebx
80100bd5:	75 91                	jne    80100b68 <leftShiftBuffer+0xb8>
80100bd7:	eb d6                	jmp    80100baf <leftShiftBuffer+0xff>
80100bd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100be0 <rmCurrLinefromConsole>:
{
80100be0:	55                   	push   %ebp
80100be1:	89 e5                	mov    %esp,%ebp
80100be3:	53                   	push   %ebx
80100be4:	83 ec 04             	sub    $0x4,%esp
    int length = input.rightmost - input.r;
80100be7:	8b 1d 0c 09 11 80    	mov    0x8011090c,%ebx
    while (length--) 
80100bed:	2b 1d 00 09 11 80    	sub    0x80110900,%ebx
80100bf3:	74 49                	je     80100c3e <rmCurrLinefromConsole+0x5e>
  if(panicked){
80100bf5:	a1 58 09 11 80       	mov    0x80110958,%eax
80100bfa:	85 c0                	test   %eax,%eax
80100bfc:	74 0a                	je     80100c08 <rmCurrLinefromConsole+0x28>
80100bfe:	fa                   	cli    
    for(;;)
80100bff:	eb fe                	jmp    80100bff <rmCurrLinefromConsole+0x1f>
80100c01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      uartputc('\b'); uartputc(' '); uartputc('\b');  // uart is writing to the linux shell
80100c08:	83 ec 0c             	sub    $0xc,%esp
80100c0b:	6a 08                	push   $0x8
80100c0d:	e8 6e 61 00 00       	call   80106d80 <uartputc>
80100c12:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100c19:	e8 62 61 00 00       	call   80106d80 <uartputc>
80100c1e:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100c25:	e8 56 61 00 00       	call   80106d80 <uartputc>
  if (c != RIGHT_ARROW) cgaputc(c, 0);
80100c2a:	31 d2                	xor    %edx,%edx
80100c2c:	b8 00 01 00 00       	mov    $0x100,%eax
80100c31:	e8 ca f7 ff ff       	call   80100400 <cgaputc>
    while (length--) 
80100c36:	83 c4 10             	add    $0x10,%esp
80100c39:	83 eb 01             	sub    $0x1,%ebx
80100c3c:	75 b7                	jne    80100bf5 <rmCurrLinefromConsole+0x15>
}
80100c3e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100c41:	c9                   	leave  
80100c42:	c3                   	ret    
80100c43:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100c4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100c50 <charstoOlsBuff>:
{
80100c50:	55                   	push   %ebp
    lenOfOldBuffer = input.rightmost - input.r;
80100c51:	8b 0d 0c 09 11 80    	mov    0x8011090c,%ecx
{
80100c57:	89 e5                	mov    %esp,%ebp
80100c59:	53                   	push   %ebx
    lenOfOldBuffer = input.rightmost - input.r;
80100c5a:	8b 1d 00 09 11 80    	mov    0x80110900,%ebx
80100c60:	29 d9                	sub    %ebx,%ecx
80100c62:	89 0d 00 ff 10 80    	mov    %ecx,0x8010ff00
    for (uint i = 0; i < lenOfOldBuffer; i++) 
80100c68:	74 20                	je     80100c8a <charstoOlsBuff+0x3a>
80100c6a:	31 c0                	xor    %eax,%eax
80100c6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      oldBufferArray[i] = input.buf[(input.r + i) % INPUT_BUF];
80100c70:	8d 14 03             	lea    (%ebx,%eax,1),%edx
    for (uint i = 0; i < lenOfOldBuffer; i++) 
80100c73:	83 c0 01             	add    $0x1,%eax
      oldBufferArray[i] = input.buf[(input.r + i) % INPUT_BUF];
80100c76:	83 e2 7f             	and    $0x7f,%edx
80100c79:	0f b6 92 80 08 11 80 	movzbl -0x7feef780(%edx),%edx
80100c80:	88 90 1f ff 10 80    	mov    %dl,-0x7fef00e1(%eax)
    for (uint i = 0; i < lenOfOldBuffer; i++) 
80100c86:	39 c1                	cmp    %eax,%ecx
80100c88:	75 e6                	jne    80100c70 <charstoOlsBuff+0x20>
}
80100c8a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100c8d:	c9                   	leave  
80100c8e:	c3                   	ret    
80100c8f:	90                   	nop

80100c90 <clrInpBuff>:
  input.rightmost = input.r;
80100c90:	a1 00 09 11 80       	mov    0x80110900,%eax
80100c95:	a3 0c 09 11 80       	mov    %eax,0x8011090c
  input.e = input.r;
80100c9a:	a3 08 09 11 80       	mov    %eax,0x80110908
}
80100c9f:	c3                   	ret    

80100ca0 <copyBufftoConsole>:
{
80100ca0:	55                   	push   %ebp
80100ca1:	89 e5                	mov    %esp,%ebp
80100ca3:	56                   	push   %esi
80100ca4:	8b 75 0c             	mov    0xc(%ebp),%esi
80100ca7:	53                   	push   %ebx
  while(length--) 
80100ca8:	85 f6                	test   %esi,%esi
80100caa:	74 28                	je     80100cd4 <copyBufftoConsole+0x34>
80100cac:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100caf:	01 de                	add    %ebx,%esi
  if(panicked){
80100cb1:	8b 15 58 09 11 80    	mov    0x80110958,%edx
    consputc(bufToPrintOnScreen[i]);
80100cb7:	0f be 03             	movsbl (%ebx),%eax
  if(panicked){
80100cba:	85 d2                	test   %edx,%edx
80100cbc:	74 0a                	je     80100cc8 <copyBufftoConsole+0x28>
80100cbe:	fa                   	cli    
    for(;;)
80100cbf:	eb fe                	jmp    80100cbf <copyBufftoConsole+0x1f>
80100cc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100cc8:	e8 c3 f8 ff ff       	call   80100590 <consputc.part.0>
  while(length--) 
80100ccd:	83 c3 01             	add    $0x1,%ebx
80100cd0:	39 f3                	cmp    %esi,%ebx
80100cd2:	75 dd                	jne    80100cb1 <copyBufftoConsole+0x11>
}
80100cd4:	5b                   	pop    %ebx
80100cd5:	5e                   	pop    %esi
80100cd6:	5d                   	pop    %ebp
80100cd7:	c3                   	ret    
80100cd8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100cdf:	90                   	nop

80100ce0 <copybuftoInpBuff>:
{
80100ce0:	55                   	push   %ebp
  input.e = input.r + length;
80100ce1:	8b 15 00 09 11 80    	mov    0x80110900,%edx
80100ce7:	89 d0                	mov    %edx,%eax
{
80100ce9:	89 e5                	mov    %esp,%ebp
80100ceb:	56                   	push   %esi
80100cec:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    input.buf[(input.r + i) % INPUT_BUF] = bufToSaveInInput[i];
80100cef:	8b 75 08             	mov    0x8(%ebp),%esi
{
80100cf2:	53                   	push   %ebx
    input.buf[(input.r + i) % INPUT_BUF] = bufToSaveInInput[i];
80100cf3:	29 d6                	sub    %edx,%esi
80100cf5:	8d 1c 11             	lea    (%ecx,%edx,1),%ebx
  for (uint i = 0; i < length; i++) 
80100cf8:	85 c9                	test   %ecx,%ecx
80100cfa:	74 34                	je     80100d30 <copybuftoInpBuff+0x50>
80100cfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    input.buf[(input.r + i) % INPUT_BUF] = bufToSaveInInput[i];
80100d00:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80100d04:	89 c2                	mov    %eax,%edx
  for (uint i = 0; i < length; i++) 
80100d06:	83 c0 01             	add    $0x1,%eax
    input.buf[(input.r + i) % INPUT_BUF] = bufToSaveInInput[i];
80100d09:	83 e2 7f             	and    $0x7f,%edx
80100d0c:	88 8a 80 08 11 80    	mov    %cl,-0x7feef780(%edx)
  for (uint i = 0; i < length; i++) 
80100d12:	39 c3                	cmp    %eax,%ebx
80100d14:	75 ea                	jne    80100d00 <copybuftoInpBuff+0x20>
  input.e = input.r + length;
80100d16:	89 1d 08 09 11 80    	mov    %ebx,0x80110908
  input.rightmost = input.e;
80100d1c:	89 1d 0c 09 11 80    	mov    %ebx,0x8011090c
}
80100d22:	5b                   	pop    %ebx
80100d23:	5e                   	pop    %esi
80100d24:	5d                   	pop    %ebp
80100d25:	c3                   	ret    
80100d26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100d2d:	8d 76 00             	lea    0x0(%esi),%esi
80100d30:	89 d3                	mov    %edx,%ebx
80100d32:	eb e2                	jmp    80100d16 <copybuftoInpBuff+0x36>
80100d34:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100d3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100d3f:	90                   	nop

80100d40 <saveHistoricalCommands>:
  uint len = input.rightmost - input.r - 1; // Calculate the length of the command
80100d40:	8b 0d 0c 09 11 80    	mov    0x8011090c,%ecx
80100d46:	a1 00 09 11 80       	mov    0x80110900,%eax
{
80100d4b:	55                   	push   %ebp
80100d4c:	83 e9 01             	sub    $0x1,%ecx
80100d4f:	89 e5                	mov    %esp,%ebp
80100d51:	53                   	push   %ebx
  if (len == 0) return;  // If the command is empty, return without saving
80100d52:	89 cb                	mov    %ecx,%ebx
80100d54:	29 c3                	sub    %eax,%ebx
80100d56:	74 52                	je     80100daa <saveHistoricalCommands+0x6a>
  if (hisBuffArr.numofMemHistCommands < MAX_HISTORY) 
80100d58:	8b 15 e4 ff 10 80    	mov    0x8010ffe4,%edx
  hisBuffArr.currentHistory = -1; // Set the current history index to -1 (indicating no current history selection)
80100d5e:	c7 05 e8 07 11 80 ff 	movl   $0xffffffff,0x801107e8
80100d65:	ff ff ff 
  if (hisBuffArr.numofMemHistCommands < MAX_HISTORY) 
80100d68:	83 fa 0f             	cmp    $0xf,%edx
80100d6b:	7e 43                	jle    80100db0 <saveHistoricalCommands+0x70>
  hisBuffArr.indLastCmd = (hisBuffArr.indLastCmd - 1) % MAX_HISTORY; // Update the index for the last command in the circular history buffer
80100d6d:	8b 15 a0 ff 10 80    	mov    0x8010ffa0,%edx
80100d73:	83 ea 01             	sub    $0x1,%edx
80100d76:	83 e2 0f             	and    $0xf,%edx
80100d79:	89 15 a0 ff 10 80    	mov    %edx,0x8010ffa0
  hisBuffArr.lenofeachCmdStr[hisBuffArr.indLastCmd] = len;// Store the length of the saved command in the length array
80100d7f:	89 1c 95 a4 ff 10 80 	mov    %ebx,-0x7fef005c(,%edx,4)
  for (uint i = 0; i < len; i++) 
80100d86:	c1 e2 07             	shl    $0x7,%edx
80100d89:	29 c2                	sub    %eax,%edx
80100d8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100d8f:	90                   	nop
    hisBuffArr.actualCmdStr[hisBuffArr.indLastCmd][i] =  input.buf[(input.r + i) % INPUT_BUF];// Copy each character of the command to the historical command buffer
80100d90:	89 c3                	mov    %eax,%ebx
80100d92:	83 e3 7f             	and    $0x7f,%ebx
80100d95:	0f b6 9b 80 08 11 80 	movzbl -0x7feef780(%ebx),%ebx
80100d9c:	88 9c 02 e8 ff 10 80 	mov    %bl,-0x7fef0018(%edx,%eax,1)
  for (uint i = 0; i < len; i++) 
80100da3:	83 c0 01             	add    $0x1,%eax
80100da6:	39 c1                	cmp    %eax,%ecx
80100da8:	75 e6                	jne    80100d90 <saveHistoricalCommands+0x50>
}
80100daa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100dad:	c9                   	leave  
80100dae:	c3                   	ret    
80100daf:	90                   	nop
    hisBuffArr.numofMemHistCommands++;// Increment the count of stored historical commands if within capacity
80100db0:	83 c2 01             	add    $0x1,%edx
80100db3:	89 15 e4 ff 10 80    	mov    %edx,0x8010ffe4
80100db9:	eb b2                	jmp    80100d6d <saveHistoricalCommands+0x2d>
80100dbb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100dbf:	90                   	nop

80100dc0 <consoleintr>:
{
80100dc0:	55                   	push   %ebp
80100dc1:	89 e5                	mov    %esp,%ebp
80100dc3:	57                   	push   %edi
  int c, doprocdump = 0;
80100dc4:	31 ff                	xor    %edi,%edi
{
80100dc6:	56                   	push   %esi
80100dc7:	53                   	push   %ebx
80100dc8:	83 ec 38             	sub    $0x38,%esp
80100dcb:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&cons.lock);
80100dce:	68 20 09 11 80       	push   $0x80110920
80100dd3:	e8 18 47 00 00       	call   801054f0 <acquire>
  while((c = getc()) >= 0){
80100dd8:	83 c4 10             	add    $0x10,%esp
80100ddb:	ff d6                	call   *%esi
80100ddd:	89 c3                	mov    %eax,%ebx
80100ddf:	85 c0                	test   %eax,%eax
80100de1:	0f 88 a0 00 00 00    	js     80100e87 <consoleintr+0xc7>
80100de7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100dee:	66 90                	xchg   %ax,%ax
    switch(c){
80100df0:	81 fb e2 00 00 00    	cmp    $0xe2,%ebx
80100df6:	0f 84 ac 01 00 00    	je     80100fa8 <consoleintr+0x1e8>
80100dfc:	7f 42                	jg     80100e40 <consoleintr+0x80>
80100dfe:	83 fb 15             	cmp    $0x15,%ebx
80100e01:	0f 84 59 01 00 00    	je     80100f60 <consoleintr+0x1a0>
80100e07:	7e 5f                	jle    80100e68 <consoleintr+0xa8>
80100e09:	83 fb 7f             	cmp    $0x7f,%ebx
80100e0c:	0f 85 26 03 00 00    	jne    80101138 <consoleintr+0x378>
        if (input.rightmost != input.e && input.e != input.w) { // caret isn't at the end of the line
80100e12:	a1 0c 09 11 80       	mov    0x8011090c,%eax
80100e17:	8b 15 08 09 11 80    	mov    0x80110908,%edx
          while(input.e != input.w &&
80100e1d:	8b 0d 04 09 11 80    	mov    0x80110904,%ecx
        if (input.rightmost != input.e && input.e != input.w) { // caret isn't at the end of the line
80100e23:	39 d0                	cmp    %edx,%eax
80100e25:	0f 84 c5 02 00 00    	je     801010f0 <consoleintr+0x330>
80100e2b:	39 ca                	cmp    %ecx,%edx
80100e2d:	74 ac                	je     80100ddb <consoleintr+0x1b>
          leftShiftBuffer();
80100e2f:	e8 7c fc ff ff       	call   80100ab0 <leftShiftBuffer>
          break;
80100e34:	eb a5                	jmp    80100ddb <consoleintr+0x1b>
80100e36:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100e3d:	8d 76 00             	lea    0x0(%esi),%esi
    switch(c){
80100e40:	81 fb e4 00 00 00    	cmp    $0xe4,%ebx
80100e46:	0f 84 e4 00 00 00    	je     80100f30 <consoleintr+0x170>
80100e4c:	81 fb e5 00 00 00    	cmp    $0xe5,%ebx
80100e52:	75 5c                	jne    80100eb0 <consoleintr+0xf0>
  if(panicked){
80100e54:	8b 0d 58 09 11 80    	mov    0x80110958,%ecx
80100e5a:	85 c9                	test   %ecx,%ecx
80100e5c:	0f 84 0e 02 00 00    	je     80101070 <consoleintr+0x2b0>
80100e62:	fa                   	cli    
    for(;;)
80100e63:	eb fe                	jmp    80100e63 <consoleintr+0xa3>
80100e65:	8d 76 00             	lea    0x0(%esi),%esi
    switch(c){
80100e68:	83 fb 08             	cmp    $0x8,%ebx
80100e6b:	74 a5                	je     80100e12 <consoleintr+0x52>
80100e6d:	83 fb 10             	cmp    $0x10,%ebx
80100e70:	0f 85 b6 02 00 00    	jne    8010112c <consoleintr+0x36c>
  while((c = getc()) >= 0){
80100e76:	ff d6                	call   *%esi
    switch(c){
80100e78:	bf 01 00 00 00       	mov    $0x1,%edi
  while((c = getc()) >= 0){
80100e7d:	89 c3                	mov    %eax,%ebx
80100e7f:	85 c0                	test   %eax,%eax
80100e81:	0f 89 69 ff ff ff    	jns    80100df0 <consoleintr+0x30>
  release(&cons.lock);
80100e87:	83 ec 0c             	sub    $0xc,%esp
80100e8a:	68 20 09 11 80       	push   $0x80110920
80100e8f:	e8 fc 45 00 00       	call   80105490 <release>
  if(doprocdump) {
80100e94:	83 c4 10             	add    $0x10,%esp
80100e97:	85 ff                	test   %edi,%edi
80100e99:	0f 85 81 02 00 00    	jne    80101120 <consoleintr+0x360>
}
80100e9f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ea2:	5b                   	pop    %ebx
80100ea3:	5e                   	pop    %esi
80100ea4:	5f                   	pop    %edi
80100ea5:	5d                   	pop    %ebp
80100ea6:	c3                   	ret    
80100ea7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100eae:	66 90                	xchg   %ax,%ax
    switch(c){
80100eb0:	81 fb e3 00 00 00    	cmp    $0xe3,%ebx
80100eb6:	0f 85 7c 02 00 00    	jne    80101138 <consoleintr+0x378>
        switch(hisBuffArr.currentHistory)
80100ebc:	a1 e8 07 11 80       	mov    0x801107e8,%eax
80100ec1:	83 f8 ff             	cmp    $0xffffffff,%eax
80100ec4:	0f 84 11 ff ff ff    	je     80100ddb <consoleintr+0x1b>
80100eca:	85 c0                	test   %eax,%eax
80100ecc:	0f 84 ad 01 00 00    	je     8010107f <consoleintr+0x2bf>
            rmCurrLinefromConsole();
80100ed2:	e8 09 fd ff ff       	call   80100be0 <rmCurrLinefromConsole>
            hisBuffArr.currentHistory--;
80100ed7:	a1 e8 07 11 80       	mov    0x801107e8,%eax
80100edc:	8d 58 ff             	lea    -0x1(%eax),%ebx
80100edf:	89 1d e8 07 11 80    	mov    %ebx,0x801107e8
            tempIndex = (hisBuffArr.indLastCmd + hisBuffArr.currentHistory)%MAX_HISTORY;
80100ee5:	03 1d a0 ff 10 80    	add    0x8010ffa0,%ebx
80100eeb:	83 e3 0f             	and    $0xf,%ebx
            copyBufftoConsole(hisBuffArr.actualCmdStr[ tempIndex]  , hisBuffArr.lenofeachCmdStr[tempIndex]);
80100eee:	89 da                	mov    %ebx,%edx
80100ef0:	8b 04 9d a4 ff 10 80 	mov    -0x7fef005c(,%ebx,4),%eax
80100ef7:	c1 e2 07             	shl    $0x7,%edx
80100efa:	81 c2 e8 ff 10 80    	add    $0x8010ffe8,%edx
  while(length--) 
80100f00:	85 c0                	test   %eax,%eax
80100f02:	0f 84 e0 06 00 00    	je     801015e8 <consoleintr+0x828>
80100f08:	01 d0                	add    %edx,%eax
80100f0a:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100f0d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100f10:	89 5d dc             	mov    %ebx,-0x24(%ebp)
80100f13:	89 d3                	mov    %edx,%ebx
  if(panicked){
80100f15:	8b 15 58 09 11 80    	mov    0x80110958,%edx
    consputc(bufToPrintOnScreen[i]);
80100f1b:	0f be 03             	movsbl (%ebx),%eax
  if(panicked){
80100f1e:	85 d2                	test   %edx,%edx
80100f20:	0f 84 e1 03 00 00    	je     80101307 <consoleintr+0x547>
80100f26:	fa                   	cli    
    for(;;)
80100f27:	eb fe                	jmp    80100f27 <consoleintr+0x167>
80100f29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        if (input.e != input.w) {
80100f30:	a1 08 09 11 80       	mov    0x80110908,%eax
80100f35:	3b 05 04 09 11 80    	cmp    0x80110904,%eax
80100f3b:	0f 84 9a fe ff ff    	je     80100ddb <consoleintr+0x1b>
  if(panicked){
80100f41:	8b 1d 58 09 11 80    	mov    0x80110958,%ebx
          input.e--; // e is for edit index, so on left arrow we can simply decrease the index and move to the previous
80100f47:	83 e8 01             	sub    $0x1,%eax
80100f4a:	a3 08 09 11 80       	mov    %eax,0x80110908
  if(panicked){
80100f4f:	85 db                	test   %ebx,%ebx
80100f51:	0f 84 74 04 00 00    	je     801013cb <consoleintr+0x60b>
80100f57:	fa                   	cli    
    for(;;)
80100f58:	eb fe                	jmp    80100f58 <consoleintr+0x198>
80100f5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        if (input.rightmost > input.e) { // caret isn't at the end of the line
80100f60:	a1 0c 09 11 80       	mov    0x8011090c,%eax
          while(input.e != input.w &&
80100f65:	8b 0d 04 09 11 80    	mov    0x80110904,%ecx
        if (input.rightmost > input.e) { // caret isn't at the end of the line
80100f6b:	8b 1d 08 09 11 80    	mov    0x80110908,%ebx
80100f71:	89 45 e0             	mov    %eax,-0x20(%ebp)
          while(input.e != input.w &&
80100f74:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
        if (input.rightmost > input.e) { // caret isn't at the end of the line
80100f77:	39 d8                	cmp    %ebx,%eax
80100f79:	0f 86 b1 00 00 00    	jbe    80101030 <consoleintr+0x270>
          for (i = 0; i < placestoshift; i++) {
80100f7f:	31 c9                	xor    %ecx,%ecx
80100f81:	89 d8                	mov    %ebx,%eax
80100f83:	2b 45 e4             	sub    -0x1c(%ebp),%eax
80100f86:	89 45 dc             	mov    %eax,-0x24(%ebp)
80100f89:	0f 84 a9 02 00 00    	je     80101238 <consoleintr+0x478>
80100f8f:	89 5d d8             	mov    %ebx,-0x28(%ebp)
80100f92:	89 cb                	mov    %ecx,%ebx
  if(panicked){
80100f94:	8b 0d 58 09 11 80    	mov    0x80110958,%ecx
80100f9a:	85 c9                	test   %ecx,%ecx
80100f9c:	0f 84 6e 02 00 00    	je     80101210 <consoleintr+0x450>
80100fa2:	fa                   	cli    
    for(;;)
80100fa3:	eb fe                	jmp    80100fa3 <consoleintr+0x1e3>
80100fa5:	8d 76 00             	lea    0x0(%esi),%esi
       if (hisBuffArr.currentHistory < hisBuffArr.numofMemHistCommands-1 ) // if yes then still more historical commands to display
80100fa8:	a1 e4 ff 10 80       	mov    0x8010ffe4,%eax
80100fad:	83 e8 01             	sub    $0x1,%eax
80100fb0:	39 05 e8 07 11 80    	cmp    %eax,0x801107e8
80100fb6:	0f 8d 1f fe ff ff    	jge    80100ddb <consoleintr+0x1b>
          rmCurrLinefromConsole(); // clears the current console line
80100fbc:	e8 1f fc ff ff       	call   80100be0 <rmCurrLinefromConsole>
          if (hisBuffArr.currentHistory == -1) // if no history, moves the chars to "old" commands' buffer
80100fc1:	8b 15 e8 07 11 80    	mov    0x801107e8,%edx
    lenOfOldBuffer = input.rightmost - input.r;
80100fc7:	a1 00 09 11 80       	mov    0x80110900,%eax
          if (hisBuffArr.currentHistory == -1) // if no history, moves the chars to "old" commands' buffer
80100fcc:	83 fa ff             	cmp    $0xffffffff,%edx
80100fcf:	0f 84 27 05 00 00    	je     801014fc <consoleintr+0x73c>
          hisBuffArr.currentHistory++;// incremented to move next cmd in history
80100fd5:	8d 5a 01             	lea    0x1(%edx),%ebx
  input.rightmost = input.r;
80100fd8:	a3 0c 09 11 80       	mov    %eax,0x8011090c
          hisBuffArr.currentHistory++;// incremented to move next cmd in history
80100fdd:	89 1d e8 07 11 80    	mov    %ebx,0x801107e8
          tempIndex = (hisBuffArr.indLastCmd + hisBuffArr.currentHistory) % MAX_HISTORY; // can be used to access specific command from the history 
80100fe3:	03 1d a0 ff 10 80    	add    0x8010ffa0,%ebx
80100fe9:	83 e3 0f             	and    $0xf,%ebx
  input.e = input.r;
80100fec:	a3 08 09 11 80       	mov    %eax,0x80110908
          copyBufftoConsole(hisBuffArr.actualCmdStr[ tempIndex], hisBuffArr.lenofeachCmdStr[tempIndex]);
80100ff1:	89 d9                	mov    %ebx,%ecx
80100ff3:	8b 14 9d a4 ff 10 80 	mov    -0x7fef005c(,%ebx,4),%edx
80100ffa:	c1 e1 07             	shl    $0x7,%ecx
80100ffd:	81 c1 e8 ff 10 80    	add    $0x8010ffe8,%ecx
80101003:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  while(length--) 
80101006:	85 d2                	test   %edx,%edx
80101008:	0f 84 3d 05 00 00    	je     8010154b <consoleintr+0x78b>
8010100e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101011:	89 5d dc             	mov    %ebx,-0x24(%ebp)
80101014:	01 c2                	add    %eax,%edx
80101016:	89 c3                	mov    %eax,%ebx
80101018:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(panicked){
8010101b:	8b 15 58 09 11 80    	mov    0x80110958,%edx
    consputc(bufToPrintOnScreen[i]);
80101021:	0f be 03             	movsbl (%ebx),%eax
  if(panicked){
80101024:	85 d2                	test   %edx,%edx
80101026:	0f 84 3f 03 00 00    	je     8010136b <consoleintr+0x5ab>
8010102c:	fa                   	cli    
    for(;;)
8010102d:	eb fe                	jmp    8010102d <consoleintr+0x26d>
8010102f:	90                   	nop
          while(input.e != input.w &&
80101030:	39 cb                	cmp    %ecx,%ebx
80101032:	0f 84 a3 fd ff ff    	je     80100ddb <consoleintr+0x1b>
                input.buf[(input.e - 1) % INPUT_BUF] != '\n'){
80101038:	8d 43 ff             	lea    -0x1(%ebx),%eax
8010103b:	89 c2                	mov    %eax,%edx
8010103d:	83 e2 7f             	and    $0x7f,%edx
          while(input.e != input.w &&
80101040:	80 ba 80 08 11 80 0a 	cmpb   $0xa,-0x7feef780(%edx)
80101047:	0f 84 8e fd ff ff    	je     80100ddb <consoleintr+0x1b>
  if(panicked){
8010104d:	8b 1d 58 09 11 80    	mov    0x80110958,%ebx
            input.rightmost--;
80101053:	83 2d 0c 09 11 80 01 	subl   $0x1,0x8011090c
            input.e--;
8010105a:	a3 08 09 11 80       	mov    %eax,0x80110908
  if(panicked){
8010105f:	85 db                	test   %ebx,%ebx
80101061:	0f 84 59 01 00 00    	je     801011c0 <consoleintr+0x400>
80101067:	fa                   	cli    
    for(;;)
80101068:	eb fe                	jmp    80101068 <consoleintr+0x2a8>
8010106a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101070:	b8 e5 00 00 00       	mov    $0xe5,%eax
80101075:	e8 16 f5 ff ff       	call   80100590 <consputc.part.0>
}
8010107a:	e9 5c fd ff ff       	jmp    80100ddb <consoleintr+0x1b>
            rmCurrLinefromConsole();
8010107f:	e8 5c fb ff ff       	call   80100be0 <rmCurrLinefromConsole>
            copybuftoInpBuff(oldBufferArray, lenOfOldBuffer);// current cmd added to buffer n can be navigated now
80101084:	8b 1d 00 ff 10 80    	mov    0x8010ff00,%ebx
  for (uint i = 0; i < length; i++) 
8010108a:	85 db                	test   %ebx,%ebx
8010108c:	0f 84 c0 04 00 00    	je     80101552 <consoleintr+0x792>
    input.buf[(input.r + i) % INPUT_BUF] = bufToSaveInInput[i];
80101092:	8b 0d 00 09 11 80    	mov    0x80110900,%ecx
  for (uint i = 0; i < length; i++) 
80101098:	31 c0                	xor    %eax,%eax
8010109a:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010109d:	8d 76 00             	lea    0x0(%esi),%esi
    input.buf[(input.r + i) % INPUT_BUF] = bufToSaveInInput[i];
801010a0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801010a3:	8d 14 08             	lea    (%eax,%ecx,1),%edx
801010a6:	0f b6 88 20 ff 10 80 	movzbl -0x7fef00e0(%eax),%ecx
  for (uint i = 0; i < length; i++) 
801010ad:	83 c0 01             	add    $0x1,%eax
    input.buf[(input.r + i) % INPUT_BUF] = bufToSaveInInput[i];
801010b0:	83 e2 7f             	and    $0x7f,%edx
801010b3:	88 8a 80 08 11 80    	mov    %cl,-0x7feef780(%edx)
  for (uint i = 0; i < length; i++) 
801010b9:	39 c3                	cmp    %eax,%ebx
801010bb:	75 e3                	jne    801010a0 <consoleintr+0x2e0>
801010bd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  input.rightmost = input.e;
801010c0:	31 d2                	xor    %edx,%edx
801010c2:	89 75 e4             	mov    %esi,-0x1c(%ebp)
801010c5:	89 de                	mov    %ebx,%esi
  input.e = input.r + length;
801010c7:	01 d9                	add    %ebx,%ecx
801010c9:	89 d3                	mov    %edx,%ebx
801010cb:	89 0d 08 09 11 80    	mov    %ecx,0x80110908
  input.rightmost = input.e;
801010d1:	89 0d 0c 09 11 80    	mov    %ecx,0x8011090c
  if(panicked){
801010d7:	8b 0d 58 09 11 80    	mov    0x80110958,%ecx
    consputc(bufToPrintOnScreen[i]);
801010dd:	0f be 83 20 ff 10 80 	movsbl -0x7fef00e0(%ebx),%eax
  if(panicked){
801010e4:	85 c9                	test   %ecx,%ecx
801010e6:	0f 84 fc 01 00 00    	je     801012e8 <consoleintr+0x528>
801010ec:	fa                   	cli    
    for(;;)
801010ed:	eb fe                	jmp    801010ed <consoleintr+0x32d>
801010ef:	90                   	nop
        if(input.e != input.w){ // caret is at the end of the line - deleting last char
801010f0:	39 c8                	cmp    %ecx,%eax
801010f2:	0f 84 e3 fc ff ff    	je     80100ddb <consoleintr+0x1b>
  if(panicked){
801010f8:	8b 0d 58 09 11 80    	mov    0x80110958,%ecx
          input.e--;
801010fe:	83 e8 01             	sub    $0x1,%eax
80101101:	a3 08 09 11 80       	mov    %eax,0x80110908
          input.rightmost--;
80101106:	a3 0c 09 11 80       	mov    %eax,0x8011090c
  if(panicked){
8010110b:	85 c9                	test   %ecx,%ecx
8010110d:	0f 84 d6 02 00 00    	je     801013e9 <consoleintr+0x629>
80101113:	fa                   	cli    
    for(;;)
80101114:	eb fe                	jmp    80101114 <consoleintr+0x354>
80101116:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010111d:	8d 76 00             	lea    0x0(%esi),%esi
}
80101120:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101123:	5b                   	pop    %ebx
80101124:	5e                   	pop    %esi
80101125:	5f                   	pop    %edi
80101126:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80101127:	e9 c4 3e 00 00       	jmp    80104ff0 <procdump>
        if(c != 0 && input.e-input.r < INPUT_BUF){
8010112c:	85 db                	test   %ebx,%ebx
8010112e:	0f 84 a7 fc ff ff    	je     80100ddb <consoleintr+0x1b>
80101134:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101138:	8b 0d 08 09 11 80    	mov    0x80110908,%ecx
8010113e:	8b 15 00 09 11 80    	mov    0x80110900,%edx
80101144:	89 c8                	mov    %ecx,%eax
80101146:	29 d0                	sub    %edx,%eax
80101148:	83 f8 7f             	cmp    $0x7f,%eax
8010114b:	0f 87 8a fc ff ff    	ja     80100ddb <consoleintr+0x1b>
          c = (c == '\r') ? '\n' : c;
80101151:	83 fb 0d             	cmp    $0xd,%ebx
80101154:	0f 84 c5 02 00 00    	je     8010141f <consoleintr+0x65f>
            input.buf[input.e % INPUT_BUF] = c;
8010115a:	88 5d d8             	mov    %bl,-0x28(%ebp)
          if (input.rightmost > input.e) { // caret isn't at the end of the line
8010115d:	a1 0c 09 11 80       	mov    0x8011090c,%eax
80101162:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            input.buf[input.e % INPUT_BUF] = c;
80101165:	89 c8                	mov    %ecx,%eax
80101167:	83 e0 7f             	and    $0x7f,%eax
8010116a:	89 45 dc             	mov    %eax,-0x24(%ebp)
            input.e++;
8010116d:	8d 41 01             	lea    0x1(%ecx),%eax
80101170:	89 45 e0             	mov    %eax,-0x20(%ebp)
          if (input.rightmost > input.e) { // caret isn't at the end of the line
80101173:	3b 4d e4             	cmp    -0x1c(%ebp),%ecx
80101176:	0f 82 fa 02 00 00    	jb     80101476 <consoleintr+0x6b6>
            input.buf[input.e % INPUT_BUF] = c;
8010117c:	8b 4d dc             	mov    -0x24(%ebp),%ecx
8010117f:	0f b6 45 d8          	movzbl -0x28(%ebp),%eax
            input.rightmost = input.e - input.rightmost == 1 ? input.e : input.rightmost;
80101183:	8b 55 e4             	mov    -0x1c(%ebp),%edx
            input.buf[input.e % INPUT_BUF] = c;
80101186:	88 81 80 08 11 80    	mov    %al,-0x7feef780(%ecx)
            input.e++;
8010118c:	8b 4d e0             	mov    -0x20(%ebp),%ecx
            input.rightmost = input.e - input.rightmost == 1 ? input.e : input.rightmost;
8010118f:	89 c8                	mov    %ecx,%eax
            input.e++;
80101191:	89 0d 08 09 11 80    	mov    %ecx,0x80110908
            input.rightmost = input.e - input.rightmost == 1 ? input.e : input.rightmost;
80101197:	29 d0                	sub    %edx,%eax
80101199:	83 f8 01             	cmp    $0x1,%eax
8010119c:	89 d0                	mov    %edx,%eax
8010119e:	0f 44 c1             	cmove  %ecx,%eax
801011a1:	a3 0c 09 11 80       	mov    %eax,0x8011090c
  if(panicked){
801011a6:	a1 58 09 11 80       	mov    0x80110958,%eax
801011ab:	85 c0                	test   %eax,%eax
801011ad:	0f 84 7a 02 00 00    	je     8010142d <consoleintr+0x66d>
801011b3:	fa                   	cli    
    for(;;)
801011b4:	eb fe                	jmp    801011b4 <consoleintr+0x3f4>
801011b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801011bd:	8d 76 00             	lea    0x0(%esi),%esi
      uartputc('\b'); uartputc(' '); uartputc('\b');  // uart is writing to the linux shell
801011c0:	83 ec 0c             	sub    $0xc,%esp
801011c3:	6a 08                	push   $0x8
801011c5:	e8 b6 5b 00 00       	call   80106d80 <uartputc>
801011ca:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801011d1:	e8 aa 5b 00 00       	call   80106d80 <uartputc>
801011d6:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801011dd:	e8 9e 5b 00 00       	call   80106d80 <uartputc>
  if (c != RIGHT_ARROW) cgaputc(c, 0);
801011e2:	31 d2                	xor    %edx,%edx
801011e4:	b8 00 01 00 00       	mov    $0x100,%eax
801011e9:	e8 12 f2 ff ff       	call   80100400 <cgaputc>
          while(input.e != input.w &&
801011ee:	8b 1d 08 09 11 80    	mov    0x80110908,%ebx
801011f4:	83 c4 10             	add    $0x10,%esp
801011f7:	3b 1d 04 09 11 80    	cmp    0x80110904,%ebx
801011fd:	0f 85 35 fe ff ff    	jne    80101038 <consoleintr+0x278>
80101203:	e9 d3 fb ff ff       	jmp    80100ddb <consoleintr+0x1b>
80101208:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010120f:	90                   	nop
      uartputc('\b');
80101210:	83 ec 0c             	sub    $0xc,%esp
          for (i = 0; i < placestoshift; i++) {
80101213:	83 c3 01             	add    $0x1,%ebx
      uartputc('\b');
80101216:	6a 08                	push   $0x8
80101218:	e8 63 5b 00 00       	call   80106d80 <uartputc>
  if (c != RIGHT_ARROW) cgaputc(c, 0);
8010121d:	31 d2                	xor    %edx,%edx
8010121f:	b8 e4 00 00 00       	mov    $0xe4,%eax
80101224:	e8 d7 f1 ff ff       	call   80100400 <cgaputc>
          for (i = 0; i < placestoshift; i++) {
80101229:	83 c4 10             	add    $0x10,%esp
8010122c:	39 5d dc             	cmp    %ebx,-0x24(%ebp)
8010122f:	0f 85 5f fd ff ff    	jne    80100f94 <consoleintr+0x1d4>
80101235:	8b 5d d8             	mov    -0x28(%ebp),%ebx
          memset(buf2, '\0', INPUT_BUF);
80101238:	83 ec 04             	sub    $0x4,%esp
          uint numtoshift = input.rightmost - input.e;
8010123b:	8b 4d e0             	mov    -0x20(%ebp),%ecx
          memset(buf2, '\0', INPUT_BUF);
8010123e:	68 80 00 00 00       	push   $0x80
80101243:	6a 00                	push   $0x0
          uint numtoshift = input.rightmost - input.e;
80101245:	29 d9                	sub    %ebx,%ecx
          memset(buf2, '\0', INPUT_BUF);
80101247:	68 80 fe 10 80       	push   $0x8010fe80
          uint numtoshift = input.rightmost - input.e;
8010124c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
          memset(buf2, '\0', INPUT_BUF);
8010124f:	e8 5c 43 00 00       	call   801055b0 <memset>
          for (i = 0; i < numtoshift; i++) {
80101254:	8b 4d d0             	mov    -0x30(%ebp),%ecx
80101257:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
8010125a:	83 c4 10             	add    $0x10,%esp
            buf2[i] = input.buf[(input.w + i + placestoshift) % INPUT_BUF];
8010125d:	8b 15 04 09 11 80    	mov    0x80110904,%edx
          for (i = 0; i < numtoshift; i++) {
80101263:	31 c0                	xor    %eax,%eax
            buf2[i] = input.buf[(input.w + i + placestoshift) % INPUT_BUF];
80101265:	89 55 d8             	mov    %edx,-0x28(%ebp)
80101268:	03 55 dc             	add    -0x24(%ebp),%edx
8010126b:	89 d3                	mov    %edx,%ebx
8010126d:	8d 76 00             	lea    0x0(%esi),%esi
80101270:	8d 14 18             	lea    (%eax,%ebx,1),%edx
          for (i = 0; i < numtoshift; i++) {
80101273:	83 c0 01             	add    $0x1,%eax
            buf2[i] = input.buf[(input.w + i + placestoshift) % INPUT_BUF];
80101276:	83 e2 7f             	and    $0x7f,%edx
80101279:	0f b6 92 80 08 11 80 	movzbl -0x7feef780(%edx),%edx
80101280:	88 90 7f fe 10 80    	mov    %dl,-0x7fef0181(%eax)
          for (i = 0; i < numtoshift; i++) {
80101286:	39 c1                	cmp    %eax,%ecx
80101288:	75 e6                	jne    80101270 <consoleintr+0x4b0>
          for (i = 0; i < numtoshift; i++) {
8010128a:	31 c0                	xor    %eax,%eax
8010128c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            input.buf[(input.w + i) % INPUT_BUF] = buf2[i];
80101290:	8b 55 d8             	mov    -0x28(%ebp),%edx
80101293:	0f b6 98 80 fe 10 80 	movzbl -0x7fef0180(%eax),%ebx
8010129a:	01 c2                	add    %eax,%edx
          for (i = 0; i < numtoshift; i++) {
8010129c:	83 c0 01             	add    $0x1,%eax
            input.buf[(input.w + i) % INPUT_BUF] = buf2[i];
8010129f:	83 e2 7f             	and    $0x7f,%edx
801012a2:	88 9a 80 08 11 80    	mov    %bl,-0x7feef780(%edx)
          for (i = 0; i < numtoshift; i++) {
801012a8:	39 c1                	cmp    %eax,%ecx
801012aa:	75 e4                	jne    80101290 <consoleintr+0x4d0>
801012ac:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
          input.e -= placestoshift;
801012af:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801012b2:	a1 08 09 11 80       	mov    0x80110908,%eax
801012b7:	29 da                	sub    %ebx,%edx
          input.rightmost -= placestoshift;
801012b9:	01 15 0c 09 11 80    	add    %edx,0x8011090c
          for (i = 0; i < numtoshift; i++) { // repaint the chars
801012bf:	31 db                	xor    %ebx,%ebx
          input.e -= placestoshift;
801012c1:	01 d0                	add    %edx,%eax
801012c3:	a3 08 09 11 80       	mov    %eax,0x80110908
            consputc(input.buf[(input.e + i) % INPUT_BUF]);
801012c8:	01 d8                	add    %ebx,%eax
  if(panicked){
801012ca:	8b 15 58 09 11 80    	mov    0x80110958,%edx
            consputc(input.buf[(input.e + i) % INPUT_BUF]);
801012d0:	83 e0 7f             	and    $0x7f,%eax
801012d3:	0f be 80 80 08 11 80 	movsbl -0x7feef780(%eax),%eax
  if(panicked){
801012da:	85 d2                	test   %edx,%edx
801012dc:	0f 84 fe 01 00 00    	je     801014e0 <consoleintr+0x720>
801012e2:	fa                   	cli    
    for(;;)
801012e3:	eb fe                	jmp    801012e3 <consoleintr+0x523>
801012e5:	8d 76 00             	lea    0x0(%esi),%esi
801012e8:	e8 a3 f2 ff ff       	call   80100590 <consputc.part.0>
    i++;
801012ed:	83 c3 01             	add    $0x1,%ebx
  while(length--) 
801012f0:	39 de                	cmp    %ebx,%esi
801012f2:	0f 85 df fd ff ff    	jne    801010d7 <consoleintr+0x317>
801012f8:	8b 75 e4             	mov    -0x1c(%ebp),%esi
            hisBuffArr.currentHistory--; // every downward move curr history index decreases in comparison from start at the arrow's cmd
801012fb:	83 2d e8 07 11 80 01 	subl   $0x1,0x801107e8
            break;
80101302:	e9 d4 fa ff ff       	jmp    80100ddb <consoleintr+0x1b>
80101307:	e8 84 f2 ff ff       	call   80100590 <consputc.part.0>
  while(length--) 
8010130c:	83 c3 01             	add    $0x1,%ebx
8010130f:	39 5d e4             	cmp    %ebx,-0x1c(%ebp)
80101312:	0f 85 fd fb ff ff    	jne    80100f15 <consoleintr+0x155>
            copybuftoInpBuff(hisBuffArr.actualCmdStr[ tempIndex]  , hisBuffArr.lenofeachCmdStr[tempIndex]);
80101318:	8b 5d dc             	mov    -0x24(%ebp),%ebx
8010131b:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010131e:	8b 04 9d a4 ff 10 80 	mov    -0x7fef005c(,%ebx,4),%eax
    input.buf[(input.r + i) % INPUT_BUF] = bufToSaveInInput[i];
80101325:	8b 1d 00 09 11 80    	mov    0x80110900,%ebx
  for (uint i = 0; i < length; i++) 
8010132b:	85 c0                	test   %eax,%eax
8010132d:	0f 84 c0 02 00 00    	je     801015f3 <consoleintr+0x833>
80101333:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
    input.buf[(input.r + i) % INPUT_BUF] = bufToSaveInInput[i];
80101336:	29 da                	sub    %ebx,%edx
  for (uint i = 0; i < length; i++) 
80101338:	89 d8                	mov    %ebx,%eax
    input.buf[(input.r + i) % INPUT_BUF] = bufToSaveInInput[i];
8010133a:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010133d:	8d 76 00             	lea    0x0(%esi),%esi
80101340:	0f b6 0c 02          	movzbl (%edx,%eax,1),%ecx
80101344:	89 c3                	mov    %eax,%ebx
  for (uint i = 0; i < length; i++) 
80101346:	83 c0 01             	add    $0x1,%eax
    input.buf[(input.r + i) % INPUT_BUF] = bufToSaveInInput[i];
80101349:	83 e3 7f             	and    $0x7f,%ebx
8010134c:	88 8b 80 08 11 80    	mov    %cl,-0x7feef780(%ebx)
  for (uint i = 0; i < length; i++) 
80101352:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
80101355:	75 e9                	jne    80101340 <consoleintr+0x580>
80101357:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  input.e = input.r + length;
8010135a:	89 0d 08 09 11 80    	mov    %ecx,0x80110908
  input.rightmost = input.e;
80101360:	89 0d 0c 09 11 80    	mov    %ecx,0x8011090c
}
80101366:	e9 70 fa ff ff       	jmp    80100ddb <consoleintr+0x1b>
8010136b:	e8 20 f2 ff ff       	call   80100590 <consputc.part.0>
  while(length--) 
80101370:	83 c3 01             	add    $0x1,%ebx
80101373:	39 5d e0             	cmp    %ebx,-0x20(%ebp)
80101376:	0f 85 9f fc ff ff    	jne    8010101b <consoleintr+0x25b>
          copybuftoInpBuff(hisBuffArr.actualCmdStr[ tempIndex], hisBuffArr.lenofeachCmdStr[tempIndex]);
8010137c:	8b 5d dc             	mov    -0x24(%ebp),%ebx
    input.buf[(input.r + i) % INPUT_BUF] = bufToSaveInInput[i];
8010137f:	a1 00 09 11 80       	mov    0x80110900,%eax
          copybuftoInpBuff(hisBuffArr.actualCmdStr[ tempIndex], hisBuffArr.lenofeachCmdStr[tempIndex]);
80101384:	8b 14 9d a4 ff 10 80 	mov    -0x7fef005c(,%ebx,4),%edx
  for (uint i = 0; i < length; i++) 
8010138b:	85 d2                	test   %edx,%edx
8010138d:	0f 84 b8 01 00 00    	je     8010154b <consoleintr+0x78b>
80101393:	01 c2                	add    %eax,%edx
    input.buf[(input.r + i) % INPUT_BUF] = bufToSaveInInput[i];
80101395:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101398:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010139b:	29 c1                	sub    %eax,%ecx
8010139d:	8d 76 00             	lea    0x0(%esi),%esi
801013a0:	0f b6 14 01          	movzbl (%ecx,%eax,1),%edx
801013a4:	89 c3                	mov    %eax,%ebx
  for (uint i = 0; i < length; i++) 
801013a6:	83 c0 01             	add    $0x1,%eax
    input.buf[(input.r + i) % INPUT_BUF] = bufToSaveInInput[i];
801013a9:	83 e3 7f             	and    $0x7f,%ebx
801013ac:	88 93 80 08 11 80    	mov    %dl,-0x7feef780(%ebx)
  for (uint i = 0; i < length; i++) 
801013b2:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
801013b5:	75 e9                	jne    801013a0 <consoleintr+0x5e0>
801013b7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  input.e = input.r + length;
801013ba:	89 15 08 09 11 80    	mov    %edx,0x80110908
  input.rightmost = input.e;
801013c0:	89 15 0c 09 11 80    	mov    %edx,0x8011090c
}
801013c6:	e9 10 fa ff ff       	jmp    80100ddb <consoleintr+0x1b>
      uartputc('\b');
801013cb:	83 ec 0c             	sub    $0xc,%esp
801013ce:	6a 08                	push   $0x8
801013d0:	e8 ab 59 00 00       	call   80106d80 <uartputc>
  if (c != RIGHT_ARROW) cgaputc(c, 0);
801013d5:	31 d2                	xor    %edx,%edx
801013d7:	b8 e4 00 00 00       	mov    $0xe4,%eax
801013dc:	e8 1f f0 ff ff       	call   80100400 <cgaputc>
801013e1:	83 c4 10             	add    $0x10,%esp
801013e4:	e9 f2 f9 ff ff       	jmp    80100ddb <consoleintr+0x1b>
      uartputc('\b'); uartputc(' '); uartputc('\b');  // uart is writing to the linux shell
801013e9:	83 ec 0c             	sub    $0xc,%esp
801013ec:	6a 08                	push   $0x8
801013ee:	e8 8d 59 00 00       	call   80106d80 <uartputc>
801013f3:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801013fa:	e8 81 59 00 00       	call   80106d80 <uartputc>
801013ff:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80101406:	e8 75 59 00 00       	call   80106d80 <uartputc>
  if (c != RIGHT_ARROW) cgaputc(c, 0);
8010140b:	31 d2                	xor    %edx,%edx
8010140d:	b8 00 01 00 00       	mov    $0x100,%eax
80101412:	e8 e9 ef ff ff       	call   80100400 <cgaputc>
80101417:	83 c4 10             	add    $0x10,%esp
8010141a:	e9 bc f9 ff ff       	jmp    80100ddb <consoleintr+0x1b>
8010141f:	c6 45 d8 0a          	movb   $0xa,-0x28(%ebp)
          c = (c == '\r') ? '\n' : c;
80101423:	bb 0a 00 00 00       	mov    $0xa,%ebx
80101428:	e9 30 fd ff ff       	jmp    8010115d <consoleintr+0x39d>
8010142d:	89 d8                	mov    %ebx,%eax
8010142f:	e8 5c f1 ff ff       	call   80100590 <consputc.part.0>
          if(c == '\n' || c == C('D') || input.rightmost == input.r + INPUT_BUF){
80101434:	83 fb 0a             	cmp    $0xa,%ebx
80101437:	74 19                	je     80101452 <consoleintr+0x692>
80101439:	83 fb 04             	cmp    $0x4,%ebx
8010143c:	74 14                	je     80101452 <consoleintr+0x692>
8010143e:	a1 00 09 11 80       	mov    0x80110900,%eax
80101443:	83 e8 80             	sub    $0xffffff80,%eax
80101446:	39 05 0c 09 11 80    	cmp    %eax,0x8011090c
8010144c:	0f 85 89 f9 ff ff    	jne    80100ddb <consoleintr+0x1b>
            saveHistoricalCommands(); // add here to save commands in his buffer
80101452:	e8 e9 f8 ff ff       	call   80100d40 <saveHistoricalCommands>
            wakeup(&input.r);
80101457:	83 ec 0c             	sub    $0xc,%esp
            input.w = input.rightmost;
8010145a:	a1 0c 09 11 80       	mov    0x8011090c,%eax
            wakeup(&input.r);
8010145f:	68 00 09 11 80       	push   $0x80110900
            input.w = input.rightmost;
80101464:	a3 04 09 11 80       	mov    %eax,0x80110904
            wakeup(&input.r);
80101469:	e8 a2 3a 00 00       	call   80104f10 <wakeup>
8010146e:	83 c4 10             	add    $0x10,%esp
80101471:	e9 65 f9 ff ff       	jmp    80100ddb <consoleintr+0x1b>
  for (uint i = 0; i < (uint)(input.rightmost - input.r); i++) {
80101476:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101479:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
80101480:	29 d0                	sub    %edx,%eax
80101482:	89 c2                	mov    %eax,%edx
80101484:	74 27                	je     801014ad <consoleintr+0x6ed>
80101486:	89 7d d4             	mov    %edi,-0x2c(%ebp)
80101489:	31 c0                	xor    %eax,%eax
8010148b:	89 d7                	mov    %edx,%edi
8010148d:	8d 76 00             	lea    0x0(%esi),%esi
    charsToBeMoved[i] = input.buf[(input.e + i) % INPUT_BUF];
80101490:	8d 14 01             	lea    (%ecx,%eax,1),%edx
  for (uint i = 0; i < (uint)(input.rightmost - input.r); i++) {
80101493:	83 c0 01             	add    $0x1,%eax
    charsToBeMoved[i] = input.buf[(input.e + i) % INPUT_BUF];
80101496:	83 e2 7f             	and    $0x7f,%edx
80101499:	0f b6 92 80 08 11 80 	movzbl -0x7feef780(%edx),%edx
801014a0:	88 90 ff 07 11 80    	mov    %dl,-0x7feef801(%eax)
  for (uint i = 0; i < (uint)(input.rightmost - input.r); i++) {
801014a6:	39 c7                	cmp    %eax,%edi
801014a8:	75 e6                	jne    80101490 <consoleintr+0x6d0>
801014aa:	8b 7d d4             	mov    -0x2c(%ebp),%edi
            input.buf[input.e % INPUT_BUF] = c;
801014ad:	0f b6 45 d8          	movzbl -0x28(%ebp),%eax
801014b1:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  if(panicked){
801014b4:	8b 15 58 09 11 80    	mov    0x80110958,%edx
            input.buf[input.e % INPUT_BUF] = c;
801014ba:	88 81 80 08 11 80    	mov    %al,-0x7feef780(%ecx)
            input.e++;
801014c0:	8b 45 e0             	mov    -0x20(%ebp),%eax
801014c3:	a3 08 09 11 80       	mov    %eax,0x80110908
            input.rightmost++;
801014c8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801014cb:	83 c0 01             	add    $0x1,%eax
801014ce:	a3 0c 09 11 80       	mov    %eax,0x8011090c
  if(panicked){
801014d3:	85 d2                	test   %edx,%edx
801014d5:	74 63                	je     8010153a <consoleintr+0x77a>
801014d7:	fa                   	cli    
    for(;;)
801014d8:	eb fe                	jmp    801014d8 <consoleintr+0x718>
801014da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801014e0:	89 4d d8             	mov    %ecx,-0x28(%ebp)
          for (i = 0; i < numtoshift; i++) { // repaint the chars
801014e3:	83 c3 01             	add    $0x1,%ebx
801014e6:	e8 a5 f0 ff ff       	call   80100590 <consputc.part.0>
801014eb:	8b 4d d8             	mov    -0x28(%ebp),%ecx
801014ee:	39 d9                	cmp    %ebx,%ecx
801014f0:	74 74                	je     80101566 <consoleintr+0x7a6>
            consputc(input.buf[(input.e + i) % INPUT_BUF]);
801014f2:	a1 08 09 11 80       	mov    0x80110908,%eax
801014f7:	e9 cc fd ff ff       	jmp    801012c8 <consoleintr+0x508>
    lenOfOldBuffer = input.rightmost - input.r;
801014fc:	8b 1d 0c 09 11 80    	mov    0x8011090c,%ebx
80101502:	29 c3                	sub    %eax,%ebx
80101504:	89 1d 00 ff 10 80    	mov    %ebx,0x8010ff00
    for (uint i = 0; i < lenOfOldBuffer; i++) 
8010150a:	0f 84 c5 fa ff ff    	je     80100fd5 <consoleintr+0x215>
80101510:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101513:	31 c9                	xor    %ecx,%ecx
80101515:	8d 76 00             	lea    0x0(%esi),%esi
      oldBufferArray[i] = input.buf[(input.r + i) % INPUT_BUF];
80101518:	8d 14 08             	lea    (%eax,%ecx,1),%edx
    for (uint i = 0; i < lenOfOldBuffer; i++) 
8010151b:	83 c1 01             	add    $0x1,%ecx
      oldBufferArray[i] = input.buf[(input.r + i) % INPUT_BUF];
8010151e:	83 e2 7f             	and    $0x7f,%edx
80101521:	0f b6 92 80 08 11 80 	movzbl -0x7feef780(%edx),%edx
80101528:	88 91 1f ff 10 80    	mov    %dl,-0x7fef00e1(%ecx)
    for (uint i = 0; i < lenOfOldBuffer; i++) 
8010152e:	39 cb                	cmp    %ecx,%ebx
80101530:	75 e6                	jne    80101518 <consoleintr+0x758>
80101532:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101535:	e9 9b fa ff ff       	jmp    80100fd5 <consoleintr+0x215>
8010153a:	89 d8                	mov    %ebx,%eax
8010153c:	e8 4f f0 ff ff       	call   80100590 <consputc.part.0>
            rightShiftBuffer();
80101541:	e8 ca f4 ff ff       	call   80100a10 <rightShiftBuffer>
80101546:	e9 e9 fe ff ff       	jmp    80101434 <consoleintr+0x674>
8010154b:	89 c2                	mov    %eax,%edx
8010154d:	e9 68 fe ff ff       	jmp    801013ba <consoleintr+0x5fa>
  input.e = input.r + length;
80101552:	a1 00 09 11 80       	mov    0x80110900,%eax
80101557:	a3 08 09 11 80       	mov    %eax,0x80110908
  input.rightmost = input.e;
8010155c:	a3 0c 09 11 80       	mov    %eax,0x8011090c
  while(length--) 
80101561:	e9 95 fd ff ff       	jmp    801012fb <consoleintr+0x53b>
          for (i = 0; i < placestoshift; i++) { // erase the leftover chars
80101566:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101569:	31 db                	xor    %ebx,%ebx
8010156b:	85 c0                	test   %eax,%eax
8010156d:	74 32                	je     801015a1 <consoleintr+0x7e1>
  if(panicked){
8010156f:	a1 58 09 11 80       	mov    0x80110958,%eax
80101574:	85 c0                	test   %eax,%eax
80101576:	74 08                	je     80101580 <consoleintr+0x7c0>
80101578:	fa                   	cli    
    for(;;)
80101579:	eb fe                	jmp    80101579 <consoleintr+0x7b9>
8010157b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010157f:	90                   	nop
      uartputc(c);
80101580:	83 ec 0c             	sub    $0xc,%esp
          for (i = 0; i < placestoshift; i++) { // erase the leftover chars
80101583:	83 c3 01             	add    $0x1,%ebx
      uartputc(c);
80101586:	6a 20                	push   $0x20
80101588:	e8 f3 57 00 00       	call   80106d80 <uartputc>
  if (c != RIGHT_ARROW) cgaputc(c, 0);
8010158d:	31 d2                	xor    %edx,%edx
8010158f:	b8 20 00 00 00       	mov    $0x20,%eax
80101594:	e8 67 ee ff ff       	call   80100400 <cgaputc>
          for (i = 0; i < placestoshift; i++) { // erase the leftover chars
80101599:	83 c4 10             	add    $0x10,%esp
8010159c:	39 5d dc             	cmp    %ebx,-0x24(%ebp)
8010159f:	75 ce                	jne    8010156f <consoleintr+0x7af>
          for (i = 0; i < placestoshift + numtoshift; i++) { // move the caret back to the left
801015a1:	8b 45 e0             	mov    -0x20(%ebp),%eax
801015a4:	31 db                	xor    %ebx,%ebx
801015a6:	2b 45 e4             	sub    -0x1c(%ebp),%eax
801015a9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801015ac:	0f 84 29 f8 ff ff    	je     80100ddb <consoleintr+0x1b>
  if(panicked){
801015b2:	a1 58 09 11 80       	mov    0x80110958,%eax
801015b7:	85 c0                	test   %eax,%eax
801015b9:	74 03                	je     801015be <consoleintr+0x7fe>
801015bb:	fa                   	cli    
    for(;;)
801015bc:	eb fe                	jmp    801015bc <consoleintr+0x7fc>
      uartputc('\b');
801015be:	83 ec 0c             	sub    $0xc,%esp
          for (i = 0; i < placestoshift + numtoshift; i++) { // move the caret back to the left
801015c1:	83 c3 01             	add    $0x1,%ebx
      uartputc('\b');
801015c4:	6a 08                	push   $0x8
801015c6:	e8 b5 57 00 00       	call   80106d80 <uartputc>
  if (c != RIGHT_ARROW) cgaputc(c, 0);
801015cb:	31 d2                	xor    %edx,%edx
801015cd:	b8 e4 00 00 00       	mov    $0xe4,%eax
801015d2:	e8 29 ee ff ff       	call   80100400 <cgaputc>
          for (i = 0; i < placestoshift + numtoshift; i++) { // move the caret back to the left
801015d7:	83 c4 10             	add    $0x10,%esp
801015da:	39 5d e4             	cmp    %ebx,-0x1c(%ebp)
801015dd:	75 d3                	jne    801015b2 <consoleintr+0x7f2>
801015df:	e9 f7 f7 ff ff       	jmp    80100ddb <consoleintr+0x1b>
801015e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    lenOfOldBuffer = input.rightmost - input.r;
801015e8:	8b 0d 00 09 11 80    	mov    0x80110900,%ecx
801015ee:	e9 67 fd ff ff       	jmp    8010135a <consoleintr+0x59a>
801015f3:	89 d9                	mov    %ebx,%ecx
801015f5:	e9 60 fd ff ff       	jmp    8010135a <consoleintr+0x59a>
801015fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101600 <AccessHistory>:
{
80101600:	55                   	push   %ebp
    return 2; // Check if the historyId is out of bounds
80101601:	b8 02 00 00 00       	mov    $0x2,%eax
{
80101606:	89 e5                	mov    %esp,%ebp
80101608:	53                   	push   %ebx
80101609:	83 ec 04             	sub    $0x4,%esp
8010160c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if (historyId < 0 || historyId > MAX_HISTORY - 1)
8010160f:	83 fb 0f             	cmp    $0xf,%ebx
80101612:	77 0d                	ja     80101621 <AccessHistory+0x21>
    return 1;// Check if the requested historyId is beyond the number of stored historical commands
80101614:	b8 01 00 00 00       	mov    $0x1,%eax
  if (historyId >= hisBuffArr.numofMemHistCommands)
80101619:	39 1d e4 ff 10 80    	cmp    %ebx,0x8010ffe4
8010161f:	7f 0f                	jg     80101630 <AccessHistory+0x30>
}
80101621:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101624:	c9                   	leave  
80101625:	c3                   	ret    
80101626:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010162d:	8d 76 00             	lea    0x0(%esi),%esi
  memset(buffer, '\0', INPUT_BUF); // Clear the buffer before copying the historical command
80101630:	83 ec 04             	sub    $0x4,%esp
80101633:	68 80 00 00 00       	push   $0x80
80101638:	6a 00                	push   $0x0
8010163a:	ff 75 08             	push   0x8(%ebp)
8010163d:	e8 6e 3f 00 00       	call   801055b0 <memset>
  int tempIndex = (hisBuffArr.indLastCmd + historyId) % MAX_HISTORY; // Calculate the index in the circular history buffer
80101642:	03 1d a0 ff 10 80    	add    0x8010ffa0,%ebx
  memmove(buffer, hisBuffArr.actualCmdStr[tempIndex], hisBuffArr.lenofeachCmdStr[tempIndex]);  // Copy the historical command to the provided buffer
80101648:	83 c4 0c             	add    $0xc,%esp
  int tempIndex = (hisBuffArr.indLastCmd + historyId) % MAX_HISTORY; // Calculate the index in the circular history buffer
8010164b:	83 e3 0f             	and    $0xf,%ebx
  memmove(buffer, hisBuffArr.actualCmdStr[tempIndex], hisBuffArr.lenofeachCmdStr[tempIndex]);  // Copy the historical command to the provided buffer
8010164e:	ff 34 9d a4 ff 10 80 	push   -0x7fef005c(,%ebx,4)
80101655:	c1 e3 07             	shl    $0x7,%ebx
80101658:	81 c3 e8 ff 10 80    	add    $0x8010ffe8,%ebx
8010165e:	53                   	push   %ebx
8010165f:	ff 75 08             	push   0x8(%ebp)
80101662:	e8 e9 3f 00 00       	call   80105650 <memmove>
}
80101667:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return 0;
8010166a:	83 c4 10             	add    $0x10,%esp
8010166d:	31 c0                	xor    %eax,%eax
}
8010166f:	c9                   	leave  
80101670:	c3                   	ret    
80101671:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101678:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010167f:	90                   	nop

80101680 <consoleinit>:

void
consoleinit(void)
{
80101680:	55                   	push   %ebp
80101681:	89 e5                	mov    %esp,%ebp
80101683:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80101686:	68 c8 82 10 80       	push   $0x801082c8
8010168b:	68 20 09 11 80       	push   $0x80110920
80101690:	e8 8b 3c 00 00       	call   80105320 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80101695:	58                   	pop    %eax
80101696:	5a                   	pop    %edx
80101697:	6a 00                	push   $0x0
80101699:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
8010169b:	c7 05 0c 13 11 80 80 	movl   $0x80100680,0x8011130c
801016a2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
801016a5:	c7 05 08 13 11 80 80 	movl   $0x80100280,0x80111308
801016ac:	02 10 80 
  cons.locking = 1;
801016af:	c7 05 54 09 11 80 01 	movl   $0x1,0x80110954
801016b6:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
801016b9:	e8 f2 19 00 00       	call   801030b0 <ioapicenable>

  hisBuffArr.numofMemHistCommands=0;
  hisBuffArr.indLastCmd=0;
}
801016be:	83 c4 10             	add    $0x10,%esp
  hisBuffArr.numofMemHistCommands=0;
801016c1:	c7 05 e4 ff 10 80 00 	movl   $0x0,0x8010ffe4
801016c8:	00 00 00 
  hisBuffArr.indLastCmd=0;
801016cb:	c7 05 a0 ff 10 80 00 	movl   $0x0,0x8010ffa0
801016d2:	00 00 00 
}
801016d5:	c9                   	leave  
801016d6:	c3                   	ret    
801016d7:	66 90                	xchg   %ax,%ax
801016d9:	66 90                	xchg   %ax,%ax
801016db:	66 90                	xchg   %ax,%ax
801016dd:	66 90                	xchg   %ax,%ax
801016df:	90                   	nop

801016e0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
801016e0:	55                   	push   %ebp
801016e1:	89 e5                	mov    %esp,%ebp
801016e3:	57                   	push   %edi
801016e4:	56                   	push   %esi
801016e5:	53                   	push   %ebx
801016e6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
801016ec:	e8 ef 2e 00 00       	call   801045e0 <myproc>
801016f1:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
801016f7:	e8 94 22 00 00       	call   80103990 <begin_op>

  if((ip = namei(path)) == 0){
801016fc:	83 ec 0c             	sub    $0xc,%esp
801016ff:	ff 75 08             	push   0x8(%ebp)
80101702:	e8 c9 15 00 00       	call   80102cd0 <namei>
80101707:	83 c4 10             	add    $0x10,%esp
8010170a:	85 c0                	test   %eax,%eax
8010170c:	0f 84 02 03 00 00    	je     80101a14 <exec+0x334>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80101712:	83 ec 0c             	sub    $0xc,%esp
80101715:	89 c3                	mov    %eax,%ebx
80101717:	50                   	push   %eax
80101718:	e8 93 0c 00 00       	call   801023b0 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
8010171d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80101723:	6a 34                	push   $0x34
80101725:	6a 00                	push   $0x0
80101727:	50                   	push   %eax
80101728:	53                   	push   %ebx
80101729:	e8 92 0f 00 00       	call   801026c0 <readi>
8010172e:	83 c4 20             	add    $0x20,%esp
80101731:	83 f8 34             	cmp    $0x34,%eax
80101734:	74 22                	je     80101758 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80101736:	83 ec 0c             	sub    $0xc,%esp
80101739:	53                   	push   %ebx
8010173a:	e8 01 0f 00 00       	call   80102640 <iunlockput>
    end_op();
8010173f:	e8 bc 22 00 00       	call   80103a00 <end_op>
80101744:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80101747:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010174c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010174f:	5b                   	pop    %ebx
80101750:	5e                   	pop    %esi
80101751:	5f                   	pop    %edi
80101752:	5d                   	pop    %ebp
80101753:	c3                   	ret    
80101754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80101758:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
8010175f:	45 4c 46 
80101762:	75 d2                	jne    80101736 <exec+0x56>
  if((pgdir = setupkvm()) == 0)
80101764:	e8 a7 67 00 00       	call   80107f10 <setupkvm>
80101769:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
8010176f:	85 c0                	test   %eax,%eax
80101771:	74 c3                	je     80101736 <exec+0x56>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101773:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
8010177a:	00 
8010177b:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80101781:	0f 84 ac 02 00 00    	je     80101a33 <exec+0x353>
  sz = 0;
80101787:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
8010178e:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101791:	31 ff                	xor    %edi,%edi
80101793:	e9 8e 00 00 00       	jmp    80101826 <exec+0x146>
80101798:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010179f:	90                   	nop
    if(ph.type != ELF_PROG_LOAD)
801017a0:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
801017a7:	75 6c                	jne    80101815 <exec+0x135>
    if(ph.memsz < ph.filesz)
801017a9:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
801017af:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
801017b5:	0f 82 87 00 00 00    	jb     80101842 <exec+0x162>
    if(ph.vaddr + ph.memsz < ph.vaddr)
801017bb:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
801017c1:	72 7f                	jb     80101842 <exec+0x162>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
801017c3:	83 ec 04             	sub    $0x4,%esp
801017c6:	50                   	push   %eax
801017c7:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
801017cd:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
801017d3:	e8 58 65 00 00       	call   80107d30 <allocuvm>
801017d8:	83 c4 10             	add    $0x10,%esp
801017db:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
801017e1:	85 c0                	test   %eax,%eax
801017e3:	74 5d                	je     80101842 <exec+0x162>
    if(ph.vaddr % PGSIZE != 0)
801017e5:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
801017eb:	a9 ff 0f 00 00       	test   $0xfff,%eax
801017f0:	75 50                	jne    80101842 <exec+0x162>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
801017f2:	83 ec 0c             	sub    $0xc,%esp
801017f5:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
801017fb:	ff b5 08 ff ff ff    	push   -0xf8(%ebp)
80101801:	53                   	push   %ebx
80101802:	50                   	push   %eax
80101803:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80101809:	e8 32 64 00 00       	call   80107c40 <loaduvm>
8010180e:	83 c4 20             	add    $0x20,%esp
80101811:	85 c0                	test   %eax,%eax
80101813:	78 2d                	js     80101842 <exec+0x162>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101815:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
8010181c:	83 c7 01             	add    $0x1,%edi
8010181f:	83 c6 20             	add    $0x20,%esi
80101822:	39 f8                	cmp    %edi,%eax
80101824:	7e 3a                	jle    80101860 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80101826:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
8010182c:	6a 20                	push   $0x20
8010182e:	56                   	push   %esi
8010182f:	50                   	push   %eax
80101830:	53                   	push   %ebx
80101831:	e8 8a 0e 00 00       	call   801026c0 <readi>
80101836:	83 c4 10             	add    $0x10,%esp
80101839:	83 f8 20             	cmp    $0x20,%eax
8010183c:	0f 84 5e ff ff ff    	je     801017a0 <exec+0xc0>
    freevm(pgdir);
80101842:	83 ec 0c             	sub    $0xc,%esp
80101845:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
8010184b:	e8 40 66 00 00       	call   80107e90 <freevm>
  if(ip){
80101850:	83 c4 10             	add    $0x10,%esp
80101853:	e9 de fe ff ff       	jmp    80101736 <exec+0x56>
80101858:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010185f:	90                   	nop
  sz = PGROUNDUP(sz);
80101860:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80101866:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
8010186c:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80101872:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80101878:	83 ec 0c             	sub    $0xc,%esp
8010187b:	53                   	push   %ebx
8010187c:	e8 bf 0d 00 00       	call   80102640 <iunlockput>
  end_op();
80101881:	e8 7a 21 00 00       	call   80103a00 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80101886:	83 c4 0c             	add    $0xc,%esp
80101889:	56                   	push   %esi
8010188a:	57                   	push   %edi
8010188b:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80101891:	57                   	push   %edi
80101892:	e8 99 64 00 00       	call   80107d30 <allocuvm>
80101897:	83 c4 10             	add    $0x10,%esp
8010189a:	89 c6                	mov    %eax,%esi
8010189c:	85 c0                	test   %eax,%eax
8010189e:	0f 84 94 00 00 00    	je     80101938 <exec+0x258>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
801018a4:	83 ec 08             	sub    $0x8,%esp
801018a7:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  for(argc = 0; argv[argc]; argc++) {
801018ad:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
801018af:	50                   	push   %eax
801018b0:	57                   	push   %edi
  for(argc = 0; argv[argc]; argc++) {
801018b1:	31 ff                	xor    %edi,%edi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
801018b3:	e8 f8 66 00 00       	call   80107fb0 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
801018b8:	8b 45 0c             	mov    0xc(%ebp),%eax
801018bb:	83 c4 10             	add    $0x10,%esp
801018be:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
801018c4:	8b 00                	mov    (%eax),%eax
801018c6:	85 c0                	test   %eax,%eax
801018c8:	0f 84 8b 00 00 00    	je     80101959 <exec+0x279>
801018ce:	89 b5 f0 fe ff ff    	mov    %esi,-0x110(%ebp)
801018d4:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
801018da:	eb 23                	jmp    801018ff <exec+0x21f>
801018dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801018e0:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
801018e3:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
801018ea:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
801018ed:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
801018f3:	8b 04 b8             	mov    (%eax,%edi,4),%eax
801018f6:	85 c0                	test   %eax,%eax
801018f8:	74 59                	je     80101953 <exec+0x273>
    if(argc >= MAXARG)
801018fa:	83 ff 20             	cmp    $0x20,%edi
801018fd:	74 39                	je     80101938 <exec+0x258>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
801018ff:	83 ec 0c             	sub    $0xc,%esp
80101902:	50                   	push   %eax
80101903:	e8 a8 3e 00 00       	call   801057b0 <strlen>
80101908:	29 c3                	sub    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
8010190a:	58                   	pop    %eax
8010190b:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
8010190e:	83 eb 01             	sub    $0x1,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80101911:	ff 34 b8             	push   (%eax,%edi,4)
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80101914:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80101917:	e8 94 3e 00 00       	call   801057b0 <strlen>
8010191c:	83 c0 01             	add    $0x1,%eax
8010191f:	50                   	push   %eax
80101920:	8b 45 0c             	mov    0xc(%ebp),%eax
80101923:	ff 34 b8             	push   (%eax,%edi,4)
80101926:	53                   	push   %ebx
80101927:	56                   	push   %esi
80101928:	e8 53 68 00 00       	call   80108180 <copyout>
8010192d:	83 c4 20             	add    $0x20,%esp
80101930:	85 c0                	test   %eax,%eax
80101932:	79 ac                	jns    801018e0 <exec+0x200>
80101934:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    freevm(pgdir);
80101938:	83 ec 0c             	sub    $0xc,%esp
8010193b:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80101941:	e8 4a 65 00 00       	call   80107e90 <freevm>
80101946:	83 c4 10             	add    $0x10,%esp
  return -1;
80101949:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010194e:	e9 f9 fd ff ff       	jmp    8010174c <exec+0x6c>
80101953:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80101959:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80101960:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80101962:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80101969:	00 00 00 00 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
8010196d:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
8010196f:	83 c0 0c             	add    $0xc,%eax
  ustack[1] = argc;
80101972:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  sp -= (3+argc+1) * 4;
80101978:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
8010197a:	50                   	push   %eax
8010197b:	52                   	push   %edx
8010197c:	53                   	push   %ebx
8010197d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
  ustack[0] = 0xffffffff;  // fake return PC
80101983:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
8010198a:	ff ff ff 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
8010198d:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80101993:	e8 e8 67 00 00       	call   80108180 <copyout>
80101998:	83 c4 10             	add    $0x10,%esp
8010199b:	85 c0                	test   %eax,%eax
8010199d:	78 99                	js     80101938 <exec+0x258>
  for(last=s=path; *s; s++)
8010199f:	8b 45 08             	mov    0x8(%ebp),%eax
801019a2:	8b 55 08             	mov    0x8(%ebp),%edx
801019a5:	0f b6 00             	movzbl (%eax),%eax
801019a8:	84 c0                	test   %al,%al
801019aa:	74 13                	je     801019bf <exec+0x2df>
801019ac:	89 d1                	mov    %edx,%ecx
801019ae:	66 90                	xchg   %ax,%ax
      last = s+1;
801019b0:	83 c1 01             	add    $0x1,%ecx
801019b3:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
801019b5:	0f b6 01             	movzbl (%ecx),%eax
      last = s+1;
801019b8:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
801019bb:	84 c0                	test   %al,%al
801019bd:	75 f1                	jne    801019b0 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
801019bf:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
801019c5:	83 ec 04             	sub    $0x4,%esp
801019c8:	6a 10                	push   $0x10
801019ca:	89 f8                	mov    %edi,%eax
801019cc:	52                   	push   %edx
801019cd:	83 c0 6c             	add    $0x6c,%eax
801019d0:	50                   	push   %eax
801019d1:	e8 9a 3d 00 00       	call   80105770 <safestrcpy>
  curproc->pgdir = pgdir;
801019d6:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
801019dc:	89 f8                	mov    %edi,%eax
801019de:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->sz = sz;
801019e1:	89 30                	mov    %esi,(%eax)
  curproc->pgdir = pgdir;
801019e3:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
801019e6:	89 c1                	mov    %eax,%ecx
801019e8:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
801019ee:	8b 40 18             	mov    0x18(%eax),%eax
801019f1:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
801019f4:	8b 41 18             	mov    0x18(%ecx),%eax
801019f7:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
801019fa:	89 0c 24             	mov    %ecx,(%esp)
801019fd:	e8 ae 60 00 00       	call   80107ab0 <switchuvm>
  freevm(oldpgdir);
80101a02:	89 3c 24             	mov    %edi,(%esp)
80101a05:	e8 86 64 00 00       	call   80107e90 <freevm>
  return 0;
80101a0a:	83 c4 10             	add    $0x10,%esp
80101a0d:	31 c0                	xor    %eax,%eax
80101a0f:	e9 38 fd ff ff       	jmp    8010174c <exec+0x6c>
    end_op();
80101a14:	e8 e7 1f 00 00       	call   80103a00 <end_op>
    cprintf("exec: fail\n");
80101a19:	83 ec 0c             	sub    $0xc,%esp
80101a1c:	68 e1 82 10 80       	push   $0x801082e1
80101a21:	e8 6a ed ff ff       	call   80100790 <cprintf>
    return -1;
80101a26:	83 c4 10             	add    $0x10,%esp
80101a29:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101a2e:	e9 19 fd ff ff       	jmp    8010174c <exec+0x6c>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101a33:	be 00 20 00 00       	mov    $0x2000,%esi
80101a38:	31 ff                	xor    %edi,%edi
80101a3a:	e9 39 fe ff ff       	jmp    80101878 <exec+0x198>
80101a3f:	90                   	nop

80101a40 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80101a40:	55                   	push   %ebp
80101a41:	89 e5                	mov    %esp,%ebp
80101a43:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80101a46:	68 ed 82 10 80       	push   $0x801082ed
80101a4b:	68 60 09 11 80       	push   $0x80110960
80101a50:	e8 cb 38 00 00       	call   80105320 <initlock>
}
80101a55:	83 c4 10             	add    $0x10,%esp
80101a58:	c9                   	leave  
80101a59:	c3                   	ret    
80101a5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101a60 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80101a60:	55                   	push   %ebp
80101a61:	89 e5                	mov    %esp,%ebp
80101a63:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101a64:	bb 94 09 11 80       	mov    $0x80110994,%ebx
{
80101a69:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80101a6c:	68 60 09 11 80       	push   $0x80110960
80101a71:	e8 7a 3a 00 00       	call   801054f0 <acquire>
80101a76:	83 c4 10             	add    $0x10,%esp
80101a79:	eb 10                	jmp    80101a8b <filealloc+0x2b>
80101a7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101a7f:	90                   	nop
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101a80:	83 c3 18             	add    $0x18,%ebx
80101a83:	81 fb f4 12 11 80    	cmp    $0x801112f4,%ebx
80101a89:	74 25                	je     80101ab0 <filealloc+0x50>
    if(f->ref == 0){
80101a8b:	8b 43 04             	mov    0x4(%ebx),%eax
80101a8e:	85 c0                	test   %eax,%eax
80101a90:	75 ee                	jne    80101a80 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80101a92:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80101a95:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80101a9c:	68 60 09 11 80       	push   $0x80110960
80101aa1:	e8 ea 39 00 00       	call   80105490 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80101aa6:	89 d8                	mov    %ebx,%eax
      return f;
80101aa8:	83 c4 10             	add    $0x10,%esp
}
80101aab:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101aae:	c9                   	leave  
80101aaf:	c3                   	ret    
  release(&ftable.lock);
80101ab0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80101ab3:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80101ab5:	68 60 09 11 80       	push   $0x80110960
80101aba:	e8 d1 39 00 00       	call   80105490 <release>
}
80101abf:	89 d8                	mov    %ebx,%eax
  return 0;
80101ac1:	83 c4 10             	add    $0x10,%esp
}
80101ac4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101ac7:	c9                   	leave  
80101ac8:	c3                   	ret    
80101ac9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101ad0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80101ad0:	55                   	push   %ebp
80101ad1:	89 e5                	mov    %esp,%ebp
80101ad3:	53                   	push   %ebx
80101ad4:	83 ec 10             	sub    $0x10,%esp
80101ad7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80101ada:	68 60 09 11 80       	push   $0x80110960
80101adf:	e8 0c 3a 00 00       	call   801054f0 <acquire>
  if(f->ref < 1)
80101ae4:	8b 43 04             	mov    0x4(%ebx),%eax
80101ae7:	83 c4 10             	add    $0x10,%esp
80101aea:	85 c0                	test   %eax,%eax
80101aec:	7e 1a                	jle    80101b08 <filedup+0x38>
    panic("filedup");
  f->ref++;
80101aee:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80101af1:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80101af4:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80101af7:	68 60 09 11 80       	push   $0x80110960
80101afc:	e8 8f 39 00 00       	call   80105490 <release>
  return f;
}
80101b01:	89 d8                	mov    %ebx,%eax
80101b03:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101b06:	c9                   	leave  
80101b07:	c3                   	ret    
    panic("filedup");
80101b08:	83 ec 0c             	sub    $0xc,%esp
80101b0b:	68 f4 82 10 80       	push   $0x801082f4
80101b10:	e8 6b e8 ff ff       	call   80100380 <panic>
80101b15:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101b20 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101b20:	55                   	push   %ebp
80101b21:	89 e5                	mov    %esp,%ebp
80101b23:	57                   	push   %edi
80101b24:	56                   	push   %esi
80101b25:	53                   	push   %ebx
80101b26:	83 ec 28             	sub    $0x28,%esp
80101b29:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80101b2c:	68 60 09 11 80       	push   $0x80110960
80101b31:	e8 ba 39 00 00       	call   801054f0 <acquire>
  if(f->ref < 1)
80101b36:	8b 53 04             	mov    0x4(%ebx),%edx
80101b39:	83 c4 10             	add    $0x10,%esp
80101b3c:	85 d2                	test   %edx,%edx
80101b3e:	0f 8e a5 00 00 00    	jle    80101be9 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
80101b44:	83 ea 01             	sub    $0x1,%edx
80101b47:	89 53 04             	mov    %edx,0x4(%ebx)
80101b4a:	75 44                	jne    80101b90 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
80101b4c:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80101b50:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80101b53:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
80101b55:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80101b5b:	8b 73 0c             	mov    0xc(%ebx),%esi
80101b5e:	88 45 e7             	mov    %al,-0x19(%ebp)
80101b61:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80101b64:	68 60 09 11 80       	push   $0x80110960
  ff = *f;
80101b69:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80101b6c:	e8 1f 39 00 00       	call   80105490 <release>

  if(ff.type == FD_PIPE)
80101b71:	83 c4 10             	add    $0x10,%esp
80101b74:	83 ff 01             	cmp    $0x1,%edi
80101b77:	74 57                	je     80101bd0 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80101b79:	83 ff 02             	cmp    $0x2,%edi
80101b7c:	74 2a                	je     80101ba8 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80101b7e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b81:	5b                   	pop    %ebx
80101b82:	5e                   	pop    %esi
80101b83:	5f                   	pop    %edi
80101b84:	5d                   	pop    %ebp
80101b85:	c3                   	ret    
80101b86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101b8d:	8d 76 00             	lea    0x0(%esi),%esi
    release(&ftable.lock);
80101b90:	c7 45 08 60 09 11 80 	movl   $0x80110960,0x8(%ebp)
}
80101b97:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b9a:	5b                   	pop    %ebx
80101b9b:	5e                   	pop    %esi
80101b9c:	5f                   	pop    %edi
80101b9d:	5d                   	pop    %ebp
    release(&ftable.lock);
80101b9e:	e9 ed 38 00 00       	jmp    80105490 <release>
80101ba3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101ba7:	90                   	nop
    begin_op();
80101ba8:	e8 e3 1d 00 00       	call   80103990 <begin_op>
    iput(ff.ip);
80101bad:	83 ec 0c             	sub    $0xc,%esp
80101bb0:	ff 75 e0             	push   -0x20(%ebp)
80101bb3:	e8 28 09 00 00       	call   801024e0 <iput>
    end_op();
80101bb8:	83 c4 10             	add    $0x10,%esp
}
80101bbb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101bbe:	5b                   	pop    %ebx
80101bbf:	5e                   	pop    %esi
80101bc0:	5f                   	pop    %edi
80101bc1:	5d                   	pop    %ebp
    end_op();
80101bc2:	e9 39 1e 00 00       	jmp    80103a00 <end_op>
80101bc7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101bce:	66 90                	xchg   %ax,%ax
    pipeclose(ff.pipe, ff.writable);
80101bd0:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80101bd4:	83 ec 08             	sub    $0x8,%esp
80101bd7:	53                   	push   %ebx
80101bd8:	56                   	push   %esi
80101bd9:	e8 82 25 00 00       	call   80104160 <pipeclose>
80101bde:	83 c4 10             	add    $0x10,%esp
}
80101be1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101be4:	5b                   	pop    %ebx
80101be5:	5e                   	pop    %esi
80101be6:	5f                   	pop    %edi
80101be7:	5d                   	pop    %ebp
80101be8:	c3                   	ret    
    panic("fileclose");
80101be9:	83 ec 0c             	sub    $0xc,%esp
80101bec:	68 fc 82 10 80       	push   $0x801082fc
80101bf1:	e8 8a e7 ff ff       	call   80100380 <panic>
80101bf6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101bfd:	8d 76 00             	lea    0x0(%esi),%esi

80101c00 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101c00:	55                   	push   %ebp
80101c01:	89 e5                	mov    %esp,%ebp
80101c03:	53                   	push   %ebx
80101c04:	83 ec 04             	sub    $0x4,%esp
80101c07:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80101c0a:	83 3b 02             	cmpl   $0x2,(%ebx)
80101c0d:	75 31                	jne    80101c40 <filestat+0x40>
    ilock(f->ip);
80101c0f:	83 ec 0c             	sub    $0xc,%esp
80101c12:	ff 73 10             	push   0x10(%ebx)
80101c15:	e8 96 07 00 00       	call   801023b0 <ilock>
    stati(f->ip, st);
80101c1a:	58                   	pop    %eax
80101c1b:	5a                   	pop    %edx
80101c1c:	ff 75 0c             	push   0xc(%ebp)
80101c1f:	ff 73 10             	push   0x10(%ebx)
80101c22:	e8 69 0a 00 00       	call   80102690 <stati>
    iunlock(f->ip);
80101c27:	59                   	pop    %ecx
80101c28:	ff 73 10             	push   0x10(%ebx)
80101c2b:	e8 60 08 00 00       	call   80102490 <iunlock>
    return 0;
  }
  return -1;
}
80101c30:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80101c33:	83 c4 10             	add    $0x10,%esp
80101c36:	31 c0                	xor    %eax,%eax
}
80101c38:	c9                   	leave  
80101c39:	c3                   	ret    
80101c3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101c40:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80101c43:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101c48:	c9                   	leave  
80101c49:	c3                   	ret    
80101c4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101c50 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101c50:	55                   	push   %ebp
80101c51:	89 e5                	mov    %esp,%ebp
80101c53:	57                   	push   %edi
80101c54:	56                   	push   %esi
80101c55:	53                   	push   %ebx
80101c56:	83 ec 0c             	sub    $0xc,%esp
80101c59:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101c5c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101c5f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101c62:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101c66:	74 60                	je     80101cc8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80101c68:	8b 03                	mov    (%ebx),%eax
80101c6a:	83 f8 01             	cmp    $0x1,%eax
80101c6d:	74 41                	je     80101cb0 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80101c6f:	83 f8 02             	cmp    $0x2,%eax
80101c72:	75 5b                	jne    80101ccf <fileread+0x7f>
    ilock(f->ip);
80101c74:	83 ec 0c             	sub    $0xc,%esp
80101c77:	ff 73 10             	push   0x10(%ebx)
80101c7a:	e8 31 07 00 00       	call   801023b0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80101c7f:	57                   	push   %edi
80101c80:	ff 73 14             	push   0x14(%ebx)
80101c83:	56                   	push   %esi
80101c84:	ff 73 10             	push   0x10(%ebx)
80101c87:	e8 34 0a 00 00       	call   801026c0 <readi>
80101c8c:	83 c4 20             	add    $0x20,%esp
80101c8f:	89 c6                	mov    %eax,%esi
80101c91:	85 c0                	test   %eax,%eax
80101c93:	7e 03                	jle    80101c98 <fileread+0x48>
      f->off += r;
80101c95:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101c98:	83 ec 0c             	sub    $0xc,%esp
80101c9b:	ff 73 10             	push   0x10(%ebx)
80101c9e:	e8 ed 07 00 00       	call   80102490 <iunlock>
    return r;
80101ca3:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80101ca6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ca9:	89 f0                	mov    %esi,%eax
80101cab:	5b                   	pop    %ebx
80101cac:	5e                   	pop    %esi
80101cad:	5f                   	pop    %edi
80101cae:	5d                   	pop    %ebp
80101caf:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80101cb0:	8b 43 0c             	mov    0xc(%ebx),%eax
80101cb3:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101cb6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101cb9:	5b                   	pop    %ebx
80101cba:	5e                   	pop    %esi
80101cbb:	5f                   	pop    %edi
80101cbc:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
80101cbd:	e9 3e 26 00 00       	jmp    80104300 <piperead>
80101cc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101cc8:	be ff ff ff ff       	mov    $0xffffffff,%esi
80101ccd:	eb d7                	jmp    80101ca6 <fileread+0x56>
  panic("fileread");
80101ccf:	83 ec 0c             	sub    $0xc,%esp
80101cd2:	68 06 83 10 80       	push   $0x80108306
80101cd7:	e8 a4 e6 ff ff       	call   80100380 <panic>
80101cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101ce0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101ce0:	55                   	push   %ebp
80101ce1:	89 e5                	mov    %esp,%ebp
80101ce3:	57                   	push   %edi
80101ce4:	56                   	push   %esi
80101ce5:	53                   	push   %ebx
80101ce6:	83 ec 1c             	sub    $0x1c,%esp
80101ce9:	8b 45 0c             	mov    0xc(%ebp),%eax
80101cec:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101cef:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101cf2:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
80101cf5:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
{
80101cf9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
80101cfc:	0f 84 bd 00 00 00    	je     80101dbf <filewrite+0xdf>
    return -1;
  if(f->type == FD_PIPE)
80101d02:	8b 03                	mov    (%ebx),%eax
80101d04:	83 f8 01             	cmp    $0x1,%eax
80101d07:	0f 84 bf 00 00 00    	je     80101dcc <filewrite+0xec>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
80101d0d:	83 f8 02             	cmp    $0x2,%eax
80101d10:	0f 85 c8 00 00 00    	jne    80101dde <filewrite+0xfe>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101d16:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101d19:	31 f6                	xor    %esi,%esi
    while(i < n){
80101d1b:	85 c0                	test   %eax,%eax
80101d1d:	7f 30                	jg     80101d4f <filewrite+0x6f>
80101d1f:	e9 94 00 00 00       	jmp    80101db8 <filewrite+0xd8>
80101d24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101d28:	01 43 14             	add    %eax,0x14(%ebx)
      iunlock(f->ip);
80101d2b:	83 ec 0c             	sub    $0xc,%esp
80101d2e:	ff 73 10             	push   0x10(%ebx)
        f->off += r;
80101d31:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101d34:	e8 57 07 00 00       	call   80102490 <iunlock>
      end_op();
80101d39:	e8 c2 1c 00 00       	call   80103a00 <end_op>

      if(r < 0)
        break;
      if(r != n1)
80101d3e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101d41:	83 c4 10             	add    $0x10,%esp
80101d44:	39 c7                	cmp    %eax,%edi
80101d46:	75 5c                	jne    80101da4 <filewrite+0xc4>
        panic("short filewrite");
      i += r;
80101d48:	01 fe                	add    %edi,%esi
    while(i < n){
80101d4a:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
80101d4d:	7e 69                	jle    80101db8 <filewrite+0xd8>
      int n1 = n - i;
80101d4f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101d52:	b8 00 06 00 00       	mov    $0x600,%eax
80101d57:	29 f7                	sub    %esi,%edi
80101d59:	39 c7                	cmp    %eax,%edi
80101d5b:	0f 4f f8             	cmovg  %eax,%edi
      begin_op();
80101d5e:	e8 2d 1c 00 00       	call   80103990 <begin_op>
      ilock(f->ip);
80101d63:	83 ec 0c             	sub    $0xc,%esp
80101d66:	ff 73 10             	push   0x10(%ebx)
80101d69:	e8 42 06 00 00       	call   801023b0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101d6e:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101d71:	57                   	push   %edi
80101d72:	ff 73 14             	push   0x14(%ebx)
80101d75:	01 f0                	add    %esi,%eax
80101d77:	50                   	push   %eax
80101d78:	ff 73 10             	push   0x10(%ebx)
80101d7b:	e8 40 0a 00 00       	call   801027c0 <writei>
80101d80:	83 c4 20             	add    $0x20,%esp
80101d83:	85 c0                	test   %eax,%eax
80101d85:	7f a1                	jg     80101d28 <filewrite+0x48>
      iunlock(f->ip);
80101d87:	83 ec 0c             	sub    $0xc,%esp
80101d8a:	ff 73 10             	push   0x10(%ebx)
80101d8d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101d90:	e8 fb 06 00 00       	call   80102490 <iunlock>
      end_op();
80101d95:	e8 66 1c 00 00       	call   80103a00 <end_op>
      if(r < 0)
80101d9a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101d9d:	83 c4 10             	add    $0x10,%esp
80101da0:	85 c0                	test   %eax,%eax
80101da2:	75 1b                	jne    80101dbf <filewrite+0xdf>
        panic("short filewrite");
80101da4:	83 ec 0c             	sub    $0xc,%esp
80101da7:	68 0f 83 10 80       	push   $0x8010830f
80101dac:	e8 cf e5 ff ff       	call   80100380 <panic>
80101db1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
    return i == n ? n : -1;
80101db8:	89 f0                	mov    %esi,%eax
80101dba:	3b 75 e4             	cmp    -0x1c(%ebp),%esi
80101dbd:	74 05                	je     80101dc4 <filewrite+0xe4>
80101dbf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
80101dc4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101dc7:	5b                   	pop    %ebx
80101dc8:	5e                   	pop    %esi
80101dc9:	5f                   	pop    %edi
80101dca:	5d                   	pop    %ebp
80101dcb:	c3                   	ret    
    return pipewrite(f->pipe, addr, n);
80101dcc:	8b 43 0c             	mov    0xc(%ebx),%eax
80101dcf:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101dd2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101dd5:	5b                   	pop    %ebx
80101dd6:	5e                   	pop    %esi
80101dd7:	5f                   	pop    %edi
80101dd8:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
80101dd9:	e9 22 24 00 00       	jmp    80104200 <pipewrite>
  panic("filewrite");
80101dde:	83 ec 0c             	sub    $0xc,%esp
80101de1:	68 15 83 10 80       	push   $0x80108315
80101de6:	e8 95 e5 ff ff       	call   80100380 <panic>
80101deb:	66 90                	xchg   %ax,%ax
80101ded:	66 90                	xchg   %ax,%ax
80101def:	90                   	nop

80101df0 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101df0:	55                   	push   %ebp
80101df1:	89 c1                	mov    %eax,%ecx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
80101df3:	89 d0                	mov    %edx,%eax
80101df5:	c1 e8 0c             	shr    $0xc,%eax
80101df8:	03 05 cc 2f 11 80    	add    0x80112fcc,%eax
{
80101dfe:	89 e5                	mov    %esp,%ebp
80101e00:	56                   	push   %esi
80101e01:	53                   	push   %ebx
80101e02:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
80101e04:	83 ec 08             	sub    $0x8,%esp
80101e07:	50                   	push   %eax
80101e08:	51                   	push   %ecx
80101e09:	e8 c2 e2 ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
80101e0e:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
80101e10:	c1 fb 03             	sar    $0x3,%ebx
80101e13:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
80101e16:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
80101e18:	83 e1 07             	and    $0x7,%ecx
80101e1b:	b8 01 00 00 00       	mov    $0x1,%eax
  if((bp->data[bi/8] & m) == 0)
80101e20:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
  m = 1 << (bi % 8);
80101e26:	d3 e0                	shl    %cl,%eax
  if((bp->data[bi/8] & m) == 0)
80101e28:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
80101e2d:	85 c1                	test   %eax,%ecx
80101e2f:	74 23                	je     80101e54 <bfree+0x64>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
80101e31:	f7 d0                	not    %eax
  log_write(bp);
80101e33:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101e36:	21 c8                	and    %ecx,%eax
80101e38:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
80101e3c:	56                   	push   %esi
80101e3d:	e8 2e 1d 00 00       	call   80103b70 <log_write>
  brelse(bp);
80101e42:	89 34 24             	mov    %esi,(%esp)
80101e45:	e8 a6 e3 ff ff       	call   801001f0 <brelse>
}
80101e4a:	83 c4 10             	add    $0x10,%esp
80101e4d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101e50:	5b                   	pop    %ebx
80101e51:	5e                   	pop    %esi
80101e52:	5d                   	pop    %ebp
80101e53:	c3                   	ret    
    panic("freeing free block");
80101e54:	83 ec 0c             	sub    $0xc,%esp
80101e57:	68 1f 83 10 80       	push   $0x8010831f
80101e5c:	e8 1f e5 ff ff       	call   80100380 <panic>
80101e61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e6f:	90                   	nop

80101e70 <balloc>:
{
80101e70:	55                   	push   %ebp
80101e71:	89 e5                	mov    %esp,%ebp
80101e73:	57                   	push   %edi
80101e74:	56                   	push   %esi
80101e75:	53                   	push   %ebx
80101e76:	83 ec 1c             	sub    $0x1c,%esp
  for(b = 0; b < sb.size; b += BPB){
80101e79:	8b 0d b4 2f 11 80    	mov    0x80112fb4,%ecx
{
80101e7f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101e82:	85 c9                	test   %ecx,%ecx
80101e84:	0f 84 87 00 00 00    	je     80101f11 <balloc+0xa1>
80101e8a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101e91:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101e94:	83 ec 08             	sub    $0x8,%esp
80101e97:	89 f0                	mov    %esi,%eax
80101e99:	c1 f8 0c             	sar    $0xc,%eax
80101e9c:	03 05 cc 2f 11 80    	add    0x80112fcc,%eax
80101ea2:	50                   	push   %eax
80101ea3:	ff 75 d8             	push   -0x28(%ebp)
80101ea6:	e8 25 e2 ff ff       	call   801000d0 <bread>
80101eab:	83 c4 10             	add    $0x10,%esp
80101eae:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101eb1:	a1 b4 2f 11 80       	mov    0x80112fb4,%eax
80101eb6:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101eb9:	31 c0                	xor    %eax,%eax
80101ebb:	eb 2f                	jmp    80101eec <balloc+0x7c>
80101ebd:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101ec0:	89 c1                	mov    %eax,%ecx
80101ec2:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101ec7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
80101eca:	83 e1 07             	and    $0x7,%ecx
80101ecd:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101ecf:	89 c1                	mov    %eax,%ecx
80101ed1:	c1 f9 03             	sar    $0x3,%ecx
80101ed4:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101ed9:	89 fa                	mov    %edi,%edx
80101edb:	85 df                	test   %ebx,%edi
80101edd:	74 41                	je     80101f20 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101edf:	83 c0 01             	add    $0x1,%eax
80101ee2:	83 c6 01             	add    $0x1,%esi
80101ee5:	3d 00 10 00 00       	cmp    $0x1000,%eax
80101eea:	74 05                	je     80101ef1 <balloc+0x81>
80101eec:	39 75 e0             	cmp    %esi,-0x20(%ebp)
80101eef:	77 cf                	ja     80101ec0 <balloc+0x50>
    brelse(bp);
80101ef1:	83 ec 0c             	sub    $0xc,%esp
80101ef4:	ff 75 e4             	push   -0x1c(%ebp)
80101ef7:	e8 f4 e2 ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
80101efc:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101f03:	83 c4 10             	add    $0x10,%esp
80101f06:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101f09:	39 05 b4 2f 11 80    	cmp    %eax,0x80112fb4
80101f0f:	77 80                	ja     80101e91 <balloc+0x21>
  panic("balloc: out of blocks");
80101f11:	83 ec 0c             	sub    $0xc,%esp
80101f14:	68 32 83 10 80       	push   $0x80108332
80101f19:	e8 62 e4 ff ff       	call   80100380 <panic>
80101f1e:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
80101f20:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101f23:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
80101f26:	09 da                	or     %ebx,%edx
80101f28:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
80101f2c:	57                   	push   %edi
80101f2d:	e8 3e 1c 00 00       	call   80103b70 <log_write>
        brelse(bp);
80101f32:	89 3c 24             	mov    %edi,(%esp)
80101f35:	e8 b6 e2 ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
80101f3a:	58                   	pop    %eax
80101f3b:	5a                   	pop    %edx
80101f3c:	56                   	push   %esi
80101f3d:	ff 75 d8             	push   -0x28(%ebp)
80101f40:	e8 8b e1 ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
80101f45:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
80101f48:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101f4a:	8d 40 5c             	lea    0x5c(%eax),%eax
80101f4d:	68 00 02 00 00       	push   $0x200
80101f52:	6a 00                	push   $0x0
80101f54:	50                   	push   %eax
80101f55:	e8 56 36 00 00       	call   801055b0 <memset>
  log_write(bp);
80101f5a:	89 1c 24             	mov    %ebx,(%esp)
80101f5d:	e8 0e 1c 00 00       	call   80103b70 <log_write>
  brelse(bp);
80101f62:	89 1c 24             	mov    %ebx,(%esp)
80101f65:	e8 86 e2 ff ff       	call   801001f0 <brelse>
}
80101f6a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f6d:	89 f0                	mov    %esi,%eax
80101f6f:	5b                   	pop    %ebx
80101f70:	5e                   	pop    %esi
80101f71:	5f                   	pop    %edi
80101f72:	5d                   	pop    %ebp
80101f73:	c3                   	ret    
80101f74:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f7f:	90                   	nop

80101f80 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101f80:	55                   	push   %ebp
80101f81:	89 e5                	mov    %esp,%ebp
80101f83:	57                   	push   %edi
80101f84:	89 c7                	mov    %eax,%edi
80101f86:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101f87:	31 f6                	xor    %esi,%esi
{
80101f89:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101f8a:	bb 94 13 11 80       	mov    $0x80111394,%ebx
{
80101f8f:	83 ec 28             	sub    $0x28,%esp
80101f92:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101f95:	68 60 13 11 80       	push   $0x80111360
80101f9a:	e8 51 35 00 00       	call   801054f0 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101f9f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
80101fa2:	83 c4 10             	add    $0x10,%esp
80101fa5:	eb 1b                	jmp    80101fc2 <iget+0x42>
80101fa7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101fae:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101fb0:	39 3b                	cmp    %edi,(%ebx)
80101fb2:	74 6c                	je     80102020 <iget+0xa0>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101fb4:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101fba:	81 fb b4 2f 11 80    	cmp    $0x80112fb4,%ebx
80101fc0:	73 26                	jae    80101fe8 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101fc2:	8b 43 08             	mov    0x8(%ebx),%eax
80101fc5:	85 c0                	test   %eax,%eax
80101fc7:	7f e7                	jg     80101fb0 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101fc9:	85 f6                	test   %esi,%esi
80101fcb:	75 e7                	jne    80101fb4 <iget+0x34>
80101fcd:	85 c0                	test   %eax,%eax
80101fcf:	75 76                	jne    80102047 <iget+0xc7>
80101fd1:	89 de                	mov    %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101fd3:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101fd9:	81 fb b4 2f 11 80    	cmp    $0x80112fb4,%ebx
80101fdf:	72 e1                	jb     80101fc2 <iget+0x42>
80101fe1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101fe8:	85 f6                	test   %esi,%esi
80101fea:	74 79                	je     80102065 <iget+0xe5>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
80101fec:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
80101fef:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101ff1:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
80101ff4:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101ffb:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
80102002:	68 60 13 11 80       	push   $0x80111360
80102007:	e8 84 34 00 00       	call   80105490 <release>

  return ip;
8010200c:	83 c4 10             	add    $0x10,%esp
}
8010200f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102012:	89 f0                	mov    %esi,%eax
80102014:	5b                   	pop    %ebx
80102015:	5e                   	pop    %esi
80102016:	5f                   	pop    %edi
80102017:	5d                   	pop    %ebp
80102018:	c3                   	ret    
80102019:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80102020:	39 53 04             	cmp    %edx,0x4(%ebx)
80102023:	75 8f                	jne    80101fb4 <iget+0x34>
      release(&icache.lock);
80102025:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80102028:	83 c0 01             	add    $0x1,%eax
      return ip;
8010202b:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
8010202d:	68 60 13 11 80       	push   $0x80111360
      ip->ref++;
80102032:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
80102035:	e8 56 34 00 00       	call   80105490 <release>
      return ip;
8010203a:	83 c4 10             	add    $0x10,%esp
}
8010203d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102040:	89 f0                	mov    %esi,%eax
80102042:	5b                   	pop    %ebx
80102043:	5e                   	pop    %esi
80102044:	5f                   	pop    %edi
80102045:	5d                   	pop    %ebp
80102046:	c3                   	ret    
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80102047:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010204d:	81 fb b4 2f 11 80    	cmp    $0x80112fb4,%ebx
80102053:	73 10                	jae    80102065 <iget+0xe5>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80102055:	8b 43 08             	mov    0x8(%ebx),%eax
80102058:	85 c0                	test   %eax,%eax
8010205a:	0f 8f 50 ff ff ff    	jg     80101fb0 <iget+0x30>
80102060:	e9 68 ff ff ff       	jmp    80101fcd <iget+0x4d>
    panic("iget: no inodes");
80102065:	83 ec 0c             	sub    $0xc,%esp
80102068:	68 48 83 10 80       	push   $0x80108348
8010206d:	e8 0e e3 ff ff       	call   80100380 <panic>
80102072:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102080 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80102080:	55                   	push   %ebp
80102081:	89 e5                	mov    %esp,%ebp
80102083:	57                   	push   %edi
80102084:	56                   	push   %esi
80102085:	89 c6                	mov    %eax,%esi
80102087:	53                   	push   %ebx
80102088:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010208b:	83 fa 0b             	cmp    $0xb,%edx
8010208e:	0f 86 8c 00 00 00    	jbe    80102120 <bmap+0xa0>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80102094:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
80102097:	83 fb 7f             	cmp    $0x7f,%ebx
8010209a:	0f 87 a2 00 00 00    	ja     80102142 <bmap+0xc2>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
801020a0:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
801020a6:	85 c0                	test   %eax,%eax
801020a8:	74 5e                	je     80102108 <bmap+0x88>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
801020aa:	83 ec 08             	sub    $0x8,%esp
801020ad:	50                   	push   %eax
801020ae:	ff 36                	push   (%esi)
801020b0:	e8 1b e0 ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
801020b5:	83 c4 10             	add    $0x10,%esp
801020b8:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
    bp = bread(ip->dev, addr);
801020bc:	89 c2                	mov    %eax,%edx
    if((addr = a[bn]) == 0){
801020be:	8b 3b                	mov    (%ebx),%edi
801020c0:	85 ff                	test   %edi,%edi
801020c2:	74 1c                	je     801020e0 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
801020c4:	83 ec 0c             	sub    $0xc,%esp
801020c7:	52                   	push   %edx
801020c8:	e8 23 e1 ff ff       	call   801001f0 <brelse>
801020cd:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
801020d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020d3:	89 f8                	mov    %edi,%eax
801020d5:	5b                   	pop    %ebx
801020d6:	5e                   	pop    %esi
801020d7:	5f                   	pop    %edi
801020d8:	5d                   	pop    %ebp
801020d9:	c3                   	ret    
801020da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801020e0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      a[bn] = addr = balloc(ip->dev);
801020e3:	8b 06                	mov    (%esi),%eax
801020e5:	e8 86 fd ff ff       	call   80101e70 <balloc>
      log_write(bp);
801020ea:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801020ed:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
801020f0:	89 03                	mov    %eax,(%ebx)
801020f2:	89 c7                	mov    %eax,%edi
      log_write(bp);
801020f4:	52                   	push   %edx
801020f5:	e8 76 1a 00 00       	call   80103b70 <log_write>
801020fa:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801020fd:	83 c4 10             	add    $0x10,%esp
80102100:	eb c2                	jmp    801020c4 <bmap+0x44>
80102102:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80102108:	8b 06                	mov    (%esi),%eax
8010210a:	e8 61 fd ff ff       	call   80101e70 <balloc>
8010210f:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80102115:	eb 93                	jmp    801020aa <bmap+0x2a>
80102117:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010211e:	66 90                	xchg   %ax,%ax
    if((addr = ip->addrs[bn]) == 0)
80102120:	8d 5a 14             	lea    0x14(%edx),%ebx
80102123:	8b 7c 98 0c          	mov    0xc(%eax,%ebx,4),%edi
80102127:	85 ff                	test   %edi,%edi
80102129:	75 a5                	jne    801020d0 <bmap+0x50>
      ip->addrs[bn] = addr = balloc(ip->dev);
8010212b:	8b 00                	mov    (%eax),%eax
8010212d:	e8 3e fd ff ff       	call   80101e70 <balloc>
80102132:	89 44 9e 0c          	mov    %eax,0xc(%esi,%ebx,4)
80102136:	89 c7                	mov    %eax,%edi
}
80102138:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010213b:	5b                   	pop    %ebx
8010213c:	89 f8                	mov    %edi,%eax
8010213e:	5e                   	pop    %esi
8010213f:	5f                   	pop    %edi
80102140:	5d                   	pop    %ebp
80102141:	c3                   	ret    
  panic("bmap: out of range");
80102142:	83 ec 0c             	sub    $0xc,%esp
80102145:	68 58 83 10 80       	push   $0x80108358
8010214a:	e8 31 e2 ff ff       	call   80100380 <panic>
8010214f:	90                   	nop

80102150 <readsb>:
{
80102150:	55                   	push   %ebp
80102151:	89 e5                	mov    %esp,%ebp
80102153:	56                   	push   %esi
80102154:	53                   	push   %ebx
80102155:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80102158:	83 ec 08             	sub    $0x8,%esp
8010215b:	6a 01                	push   $0x1
8010215d:	ff 75 08             	push   0x8(%ebp)
80102160:	e8 6b df ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80102165:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80102168:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
8010216a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010216d:	6a 1c                	push   $0x1c
8010216f:	50                   	push   %eax
80102170:	56                   	push   %esi
80102171:	e8 da 34 00 00       	call   80105650 <memmove>
  brelse(bp);
80102176:	89 5d 08             	mov    %ebx,0x8(%ebp)
80102179:	83 c4 10             	add    $0x10,%esp
}
8010217c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010217f:	5b                   	pop    %ebx
80102180:	5e                   	pop    %esi
80102181:	5d                   	pop    %ebp
  brelse(bp);
80102182:	e9 69 e0 ff ff       	jmp    801001f0 <brelse>
80102187:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010218e:	66 90                	xchg   %ax,%ax

80102190 <iinit>:
{
80102190:	55                   	push   %ebp
80102191:	89 e5                	mov    %esp,%ebp
80102193:	53                   	push   %ebx
80102194:	bb a0 13 11 80       	mov    $0x801113a0,%ebx
80102199:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010219c:	68 6b 83 10 80       	push   $0x8010836b
801021a1:	68 60 13 11 80       	push   $0x80111360
801021a6:	e8 75 31 00 00       	call   80105320 <initlock>
  for(i = 0; i < NINODE; i++) {
801021ab:	83 c4 10             	add    $0x10,%esp
801021ae:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801021b0:	83 ec 08             	sub    $0x8,%esp
801021b3:	68 72 83 10 80       	push   $0x80108372
801021b8:	53                   	push   %ebx
  for(i = 0; i < NINODE; i++) {
801021b9:	81 c3 90 00 00 00    	add    $0x90,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
801021bf:	e8 2c 30 00 00       	call   801051f0 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801021c4:	83 c4 10             	add    $0x10,%esp
801021c7:	81 fb c0 2f 11 80    	cmp    $0x80112fc0,%ebx
801021cd:	75 e1                	jne    801021b0 <iinit+0x20>
  bp = bread(dev, 1);
801021cf:	83 ec 08             	sub    $0x8,%esp
801021d2:	6a 01                	push   $0x1
801021d4:	ff 75 08             	push   0x8(%ebp)
801021d7:	e8 f4 de ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
801021dc:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
801021df:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801021e1:	8d 40 5c             	lea    0x5c(%eax),%eax
801021e4:	6a 1c                	push   $0x1c
801021e6:	50                   	push   %eax
801021e7:	68 b4 2f 11 80       	push   $0x80112fb4
801021ec:	e8 5f 34 00 00       	call   80105650 <memmove>
  brelse(bp);
801021f1:	89 1c 24             	mov    %ebx,(%esp)
801021f4:	e8 f7 df ff ff       	call   801001f0 <brelse>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801021f9:	ff 35 cc 2f 11 80    	push   0x80112fcc
801021ff:	ff 35 c8 2f 11 80    	push   0x80112fc8
80102205:	ff 35 c4 2f 11 80    	push   0x80112fc4
8010220b:	ff 35 c0 2f 11 80    	push   0x80112fc0
80102211:	ff 35 bc 2f 11 80    	push   0x80112fbc
80102217:	ff 35 b8 2f 11 80    	push   0x80112fb8
8010221d:	ff 35 b4 2f 11 80    	push   0x80112fb4
80102223:	68 d8 83 10 80       	push   $0x801083d8
80102228:	e8 63 e5 ff ff       	call   80100790 <cprintf>
}
8010222d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102230:	83 c4 30             	add    $0x30,%esp
80102233:	c9                   	leave  
80102234:	c3                   	ret    
80102235:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010223c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102240 <ialloc>:
{
80102240:	55                   	push   %ebp
80102241:	89 e5                	mov    %esp,%ebp
80102243:	57                   	push   %edi
80102244:	56                   	push   %esi
80102245:	53                   	push   %ebx
80102246:	83 ec 1c             	sub    $0x1c,%esp
80102249:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
8010224c:	83 3d bc 2f 11 80 01 	cmpl   $0x1,0x80112fbc
{
80102253:	8b 75 08             	mov    0x8(%ebp),%esi
80102256:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80102259:	0f 86 91 00 00 00    	jbe    801022f0 <ialloc+0xb0>
8010225f:	bf 01 00 00 00       	mov    $0x1,%edi
80102264:	eb 21                	jmp    80102287 <ialloc+0x47>
80102266:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010226d:	8d 76 00             	lea    0x0(%esi),%esi
    brelse(bp);
80102270:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80102273:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
80102276:	53                   	push   %ebx
80102277:	e8 74 df ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010227c:	83 c4 10             	add    $0x10,%esp
8010227f:	3b 3d bc 2f 11 80    	cmp    0x80112fbc,%edi
80102285:	73 69                	jae    801022f0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80102287:	89 f8                	mov    %edi,%eax
80102289:	83 ec 08             	sub    $0x8,%esp
8010228c:	c1 e8 03             	shr    $0x3,%eax
8010228f:	03 05 c8 2f 11 80    	add    0x80112fc8,%eax
80102295:	50                   	push   %eax
80102296:	56                   	push   %esi
80102297:	e8 34 de ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
8010229c:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
8010229f:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
801022a1:	89 f8                	mov    %edi,%eax
801022a3:	83 e0 07             	and    $0x7,%eax
801022a6:	c1 e0 06             	shl    $0x6,%eax
801022a9:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
801022ad:	66 83 39 00          	cmpw   $0x0,(%ecx)
801022b1:	75 bd                	jne    80102270 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
801022b3:	83 ec 04             	sub    $0x4,%esp
801022b6:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801022b9:	6a 40                	push   $0x40
801022bb:	6a 00                	push   $0x0
801022bd:	51                   	push   %ecx
801022be:	e8 ed 32 00 00       	call   801055b0 <memset>
      dip->type = type;
801022c3:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801022c7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801022ca:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801022cd:	89 1c 24             	mov    %ebx,(%esp)
801022d0:	e8 9b 18 00 00       	call   80103b70 <log_write>
      brelse(bp);
801022d5:	89 1c 24             	mov    %ebx,(%esp)
801022d8:	e8 13 df ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
801022dd:	83 c4 10             	add    $0x10,%esp
}
801022e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
801022e3:	89 fa                	mov    %edi,%edx
}
801022e5:	5b                   	pop    %ebx
      return iget(dev, inum);
801022e6:	89 f0                	mov    %esi,%eax
}
801022e8:	5e                   	pop    %esi
801022e9:	5f                   	pop    %edi
801022ea:	5d                   	pop    %ebp
      return iget(dev, inum);
801022eb:	e9 90 fc ff ff       	jmp    80101f80 <iget>
  panic("ialloc: no inodes");
801022f0:	83 ec 0c             	sub    $0xc,%esp
801022f3:	68 78 83 10 80       	push   $0x80108378
801022f8:	e8 83 e0 ff ff       	call   80100380 <panic>
801022fd:	8d 76 00             	lea    0x0(%esi),%esi

80102300 <iupdate>:
{
80102300:	55                   	push   %ebp
80102301:	89 e5                	mov    %esp,%ebp
80102303:	56                   	push   %esi
80102304:	53                   	push   %ebx
80102305:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80102308:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010230b:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010230e:	83 ec 08             	sub    $0x8,%esp
80102311:	c1 e8 03             	shr    $0x3,%eax
80102314:	03 05 c8 2f 11 80    	add    0x80112fc8,%eax
8010231a:	50                   	push   %eax
8010231b:	ff 73 a4             	push   -0x5c(%ebx)
8010231e:	e8 ad dd ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
80102323:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80102327:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010232a:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010232c:	8b 43 a8             	mov    -0x58(%ebx),%eax
8010232f:	83 e0 07             	and    $0x7,%eax
80102332:	c1 e0 06             	shl    $0x6,%eax
80102335:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80102339:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010233c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80102340:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80102343:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80102347:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010234b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010234f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80102353:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80102357:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010235a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010235d:	6a 34                	push   $0x34
8010235f:	53                   	push   %ebx
80102360:	50                   	push   %eax
80102361:	e8 ea 32 00 00       	call   80105650 <memmove>
  log_write(bp);
80102366:	89 34 24             	mov    %esi,(%esp)
80102369:	e8 02 18 00 00       	call   80103b70 <log_write>
  brelse(bp);
8010236e:	89 75 08             	mov    %esi,0x8(%ebp)
80102371:	83 c4 10             	add    $0x10,%esp
}
80102374:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102377:	5b                   	pop    %ebx
80102378:	5e                   	pop    %esi
80102379:	5d                   	pop    %ebp
  brelse(bp);
8010237a:	e9 71 de ff ff       	jmp    801001f0 <brelse>
8010237f:	90                   	nop

80102380 <idup>:
{
80102380:	55                   	push   %ebp
80102381:	89 e5                	mov    %esp,%ebp
80102383:	53                   	push   %ebx
80102384:	83 ec 10             	sub    $0x10,%esp
80102387:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010238a:	68 60 13 11 80       	push   $0x80111360
8010238f:	e8 5c 31 00 00       	call   801054f0 <acquire>
  ip->ref++;
80102394:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80102398:	c7 04 24 60 13 11 80 	movl   $0x80111360,(%esp)
8010239f:	e8 ec 30 00 00       	call   80105490 <release>
}
801023a4:	89 d8                	mov    %ebx,%eax
801023a6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801023a9:	c9                   	leave  
801023aa:	c3                   	ret    
801023ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801023af:	90                   	nop

801023b0 <ilock>:
{
801023b0:	55                   	push   %ebp
801023b1:	89 e5                	mov    %esp,%ebp
801023b3:	56                   	push   %esi
801023b4:	53                   	push   %ebx
801023b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
801023b8:	85 db                	test   %ebx,%ebx
801023ba:	0f 84 b7 00 00 00    	je     80102477 <ilock+0xc7>
801023c0:	8b 53 08             	mov    0x8(%ebx),%edx
801023c3:	85 d2                	test   %edx,%edx
801023c5:	0f 8e ac 00 00 00    	jle    80102477 <ilock+0xc7>
  acquiresleep(&ip->lock);
801023cb:	83 ec 0c             	sub    $0xc,%esp
801023ce:	8d 43 0c             	lea    0xc(%ebx),%eax
801023d1:	50                   	push   %eax
801023d2:	e8 59 2e 00 00       	call   80105230 <acquiresleep>
  if(ip->valid == 0){
801023d7:	8b 43 4c             	mov    0x4c(%ebx),%eax
801023da:	83 c4 10             	add    $0x10,%esp
801023dd:	85 c0                	test   %eax,%eax
801023df:	74 0f                	je     801023f0 <ilock+0x40>
}
801023e1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801023e4:	5b                   	pop    %ebx
801023e5:	5e                   	pop    %esi
801023e6:	5d                   	pop    %ebp
801023e7:	c3                   	ret    
801023e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801023ef:	90                   	nop
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801023f0:	8b 43 04             	mov    0x4(%ebx),%eax
801023f3:	83 ec 08             	sub    $0x8,%esp
801023f6:	c1 e8 03             	shr    $0x3,%eax
801023f9:	03 05 c8 2f 11 80    	add    0x80112fc8,%eax
801023ff:	50                   	push   %eax
80102400:	ff 33                	push   (%ebx)
80102402:	e8 c9 dc ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80102407:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010240a:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
8010240c:	8b 43 04             	mov    0x4(%ebx),%eax
8010240f:	83 e0 07             	and    $0x7,%eax
80102412:	c1 e0 06             	shl    $0x6,%eax
80102415:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80102419:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010241c:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
8010241f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80102423:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80102427:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010242b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010242f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80102433:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80102437:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010243b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010243e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80102441:	6a 34                	push   $0x34
80102443:	50                   	push   %eax
80102444:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102447:	50                   	push   %eax
80102448:	e8 03 32 00 00       	call   80105650 <memmove>
    brelse(bp);
8010244d:	89 34 24             	mov    %esi,(%esp)
80102450:	e8 9b dd ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
80102455:	83 c4 10             	add    $0x10,%esp
80102458:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010245d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80102464:	0f 85 77 ff ff ff    	jne    801023e1 <ilock+0x31>
      panic("ilock: no type");
8010246a:	83 ec 0c             	sub    $0xc,%esp
8010246d:	68 90 83 10 80       	push   $0x80108390
80102472:	e8 09 df ff ff       	call   80100380 <panic>
    panic("ilock");
80102477:	83 ec 0c             	sub    $0xc,%esp
8010247a:	68 8a 83 10 80       	push   $0x8010838a
8010247f:	e8 fc de ff ff       	call   80100380 <panic>
80102484:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010248b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010248f:	90                   	nop

80102490 <iunlock>:
{
80102490:	55                   	push   %ebp
80102491:	89 e5                	mov    %esp,%ebp
80102493:	56                   	push   %esi
80102494:	53                   	push   %ebx
80102495:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102498:	85 db                	test   %ebx,%ebx
8010249a:	74 28                	je     801024c4 <iunlock+0x34>
8010249c:	83 ec 0c             	sub    $0xc,%esp
8010249f:	8d 73 0c             	lea    0xc(%ebx),%esi
801024a2:	56                   	push   %esi
801024a3:	e8 28 2e 00 00       	call   801052d0 <holdingsleep>
801024a8:	83 c4 10             	add    $0x10,%esp
801024ab:	85 c0                	test   %eax,%eax
801024ad:	74 15                	je     801024c4 <iunlock+0x34>
801024af:	8b 43 08             	mov    0x8(%ebx),%eax
801024b2:	85 c0                	test   %eax,%eax
801024b4:	7e 0e                	jle    801024c4 <iunlock+0x34>
  releasesleep(&ip->lock);
801024b6:	89 75 08             	mov    %esi,0x8(%ebp)
}
801024b9:	8d 65 f8             	lea    -0x8(%ebp),%esp
801024bc:	5b                   	pop    %ebx
801024bd:	5e                   	pop    %esi
801024be:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
801024bf:	e9 cc 2d 00 00       	jmp    80105290 <releasesleep>
    panic("iunlock");
801024c4:	83 ec 0c             	sub    $0xc,%esp
801024c7:	68 9f 83 10 80       	push   $0x8010839f
801024cc:	e8 af de ff ff       	call   80100380 <panic>
801024d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801024d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801024df:	90                   	nop

801024e0 <iput>:
{
801024e0:	55                   	push   %ebp
801024e1:	89 e5                	mov    %esp,%ebp
801024e3:	57                   	push   %edi
801024e4:	56                   	push   %esi
801024e5:	53                   	push   %ebx
801024e6:	83 ec 28             	sub    $0x28,%esp
801024e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
801024ec:	8d 7b 0c             	lea    0xc(%ebx),%edi
801024ef:	57                   	push   %edi
801024f0:	e8 3b 2d 00 00       	call   80105230 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801024f5:	8b 53 4c             	mov    0x4c(%ebx),%edx
801024f8:	83 c4 10             	add    $0x10,%esp
801024fb:	85 d2                	test   %edx,%edx
801024fd:	74 07                	je     80102506 <iput+0x26>
801024ff:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80102504:	74 32                	je     80102538 <iput+0x58>
  releasesleep(&ip->lock);
80102506:	83 ec 0c             	sub    $0xc,%esp
80102509:	57                   	push   %edi
8010250a:	e8 81 2d 00 00       	call   80105290 <releasesleep>
  acquire(&icache.lock);
8010250f:	c7 04 24 60 13 11 80 	movl   $0x80111360,(%esp)
80102516:	e8 d5 2f 00 00       	call   801054f0 <acquire>
  ip->ref--;
8010251b:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
8010251f:	83 c4 10             	add    $0x10,%esp
80102522:	c7 45 08 60 13 11 80 	movl   $0x80111360,0x8(%ebp)
}
80102529:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010252c:	5b                   	pop    %ebx
8010252d:	5e                   	pop    %esi
8010252e:	5f                   	pop    %edi
8010252f:	5d                   	pop    %ebp
  release(&icache.lock);
80102530:	e9 5b 2f 00 00       	jmp    80105490 <release>
80102535:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80102538:	83 ec 0c             	sub    $0xc,%esp
8010253b:	68 60 13 11 80       	push   $0x80111360
80102540:	e8 ab 2f 00 00       	call   801054f0 <acquire>
    int r = ip->ref;
80102545:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80102548:	c7 04 24 60 13 11 80 	movl   $0x80111360,(%esp)
8010254f:	e8 3c 2f 00 00       	call   80105490 <release>
    if(r == 1){
80102554:	83 c4 10             	add    $0x10,%esp
80102557:	83 fe 01             	cmp    $0x1,%esi
8010255a:	75 aa                	jne    80102506 <iput+0x26>
8010255c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80102562:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80102565:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102568:	89 cf                	mov    %ecx,%edi
8010256a:	eb 0b                	jmp    80102577 <iput+0x97>
8010256c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80102570:	83 c6 04             	add    $0x4,%esi
80102573:	39 fe                	cmp    %edi,%esi
80102575:	74 19                	je     80102590 <iput+0xb0>
    if(ip->addrs[i]){
80102577:	8b 16                	mov    (%esi),%edx
80102579:	85 d2                	test   %edx,%edx
8010257b:	74 f3                	je     80102570 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010257d:	8b 03                	mov    (%ebx),%eax
8010257f:	e8 6c f8 ff ff       	call   80101df0 <bfree>
      ip->addrs[i] = 0;
80102584:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010258a:	eb e4                	jmp    80102570 <iput+0x90>
8010258c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80102590:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80102596:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80102599:	85 c0                	test   %eax,%eax
8010259b:	75 2d                	jne    801025ca <iput+0xea>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010259d:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
801025a0:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
801025a7:	53                   	push   %ebx
801025a8:	e8 53 fd ff ff       	call   80102300 <iupdate>
      ip->type = 0;
801025ad:	31 c0                	xor    %eax,%eax
801025af:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
801025b3:	89 1c 24             	mov    %ebx,(%esp)
801025b6:	e8 45 fd ff ff       	call   80102300 <iupdate>
      ip->valid = 0;
801025bb:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
801025c2:	83 c4 10             	add    $0x10,%esp
801025c5:	e9 3c ff ff ff       	jmp    80102506 <iput+0x26>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801025ca:	83 ec 08             	sub    $0x8,%esp
801025cd:	50                   	push   %eax
801025ce:	ff 33                	push   (%ebx)
801025d0:	e8 fb da ff ff       	call   801000d0 <bread>
801025d5:	89 7d e0             	mov    %edi,-0x20(%ebp)
801025d8:	83 c4 10             	add    $0x10,%esp
801025db:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
801025e1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(j = 0; j < NINDIRECT; j++){
801025e4:	8d 70 5c             	lea    0x5c(%eax),%esi
801025e7:	89 cf                	mov    %ecx,%edi
801025e9:	eb 0c                	jmp    801025f7 <iput+0x117>
801025eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801025ef:	90                   	nop
801025f0:	83 c6 04             	add    $0x4,%esi
801025f3:	39 f7                	cmp    %esi,%edi
801025f5:	74 0f                	je     80102606 <iput+0x126>
      if(a[j])
801025f7:	8b 16                	mov    (%esi),%edx
801025f9:	85 d2                	test   %edx,%edx
801025fb:	74 f3                	je     801025f0 <iput+0x110>
        bfree(ip->dev, a[j]);
801025fd:	8b 03                	mov    (%ebx),%eax
801025ff:	e8 ec f7 ff ff       	call   80101df0 <bfree>
80102604:	eb ea                	jmp    801025f0 <iput+0x110>
    brelse(bp);
80102606:	83 ec 0c             	sub    $0xc,%esp
80102609:	ff 75 e4             	push   -0x1c(%ebp)
8010260c:	8b 7d e0             	mov    -0x20(%ebp),%edi
8010260f:	e8 dc db ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80102614:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
8010261a:	8b 03                	mov    (%ebx),%eax
8010261c:	e8 cf f7 ff ff       	call   80101df0 <bfree>
    ip->addrs[NDIRECT] = 0;
80102621:	83 c4 10             	add    $0x10,%esp
80102624:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
8010262b:	00 00 00 
8010262e:	e9 6a ff ff ff       	jmp    8010259d <iput+0xbd>
80102633:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010263a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102640 <iunlockput>:
{
80102640:	55                   	push   %ebp
80102641:	89 e5                	mov    %esp,%ebp
80102643:	56                   	push   %esi
80102644:	53                   	push   %ebx
80102645:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102648:	85 db                	test   %ebx,%ebx
8010264a:	74 34                	je     80102680 <iunlockput+0x40>
8010264c:	83 ec 0c             	sub    $0xc,%esp
8010264f:	8d 73 0c             	lea    0xc(%ebx),%esi
80102652:	56                   	push   %esi
80102653:	e8 78 2c 00 00       	call   801052d0 <holdingsleep>
80102658:	83 c4 10             	add    $0x10,%esp
8010265b:	85 c0                	test   %eax,%eax
8010265d:	74 21                	je     80102680 <iunlockput+0x40>
8010265f:	8b 43 08             	mov    0x8(%ebx),%eax
80102662:	85 c0                	test   %eax,%eax
80102664:	7e 1a                	jle    80102680 <iunlockput+0x40>
  releasesleep(&ip->lock);
80102666:	83 ec 0c             	sub    $0xc,%esp
80102669:	56                   	push   %esi
8010266a:	e8 21 2c 00 00       	call   80105290 <releasesleep>
  iput(ip);
8010266f:	89 5d 08             	mov    %ebx,0x8(%ebp)
80102672:	83 c4 10             	add    $0x10,%esp
}
80102675:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102678:	5b                   	pop    %ebx
80102679:	5e                   	pop    %esi
8010267a:	5d                   	pop    %ebp
  iput(ip);
8010267b:	e9 60 fe ff ff       	jmp    801024e0 <iput>
    panic("iunlock");
80102680:	83 ec 0c             	sub    $0xc,%esp
80102683:	68 9f 83 10 80       	push   $0x8010839f
80102688:	e8 f3 dc ff ff       	call   80100380 <panic>
8010268d:	8d 76 00             	lea    0x0(%esi),%esi

80102690 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80102690:	55                   	push   %ebp
80102691:	89 e5                	mov    %esp,%ebp
80102693:	8b 55 08             	mov    0x8(%ebp),%edx
80102696:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80102699:	8b 0a                	mov    (%edx),%ecx
8010269b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010269e:	8b 4a 04             	mov    0x4(%edx),%ecx
801026a1:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
801026a4:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
801026a8:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
801026ab:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
801026af:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
801026b3:	8b 52 58             	mov    0x58(%edx),%edx
801026b6:	89 50 10             	mov    %edx,0x10(%eax)
}
801026b9:	5d                   	pop    %ebp
801026ba:	c3                   	ret    
801026bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801026bf:	90                   	nop

801026c0 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
801026c0:	55                   	push   %ebp
801026c1:	89 e5                	mov    %esp,%ebp
801026c3:	57                   	push   %edi
801026c4:	56                   	push   %esi
801026c5:	53                   	push   %ebx
801026c6:	83 ec 1c             	sub    $0x1c,%esp
801026c9:	8b 7d 0c             	mov    0xc(%ebp),%edi
801026cc:	8b 45 08             	mov    0x8(%ebp),%eax
801026cf:	8b 75 10             	mov    0x10(%ebp),%esi
801026d2:	89 7d e0             	mov    %edi,-0x20(%ebp)
801026d5:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801026d8:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
801026dd:	89 45 d8             	mov    %eax,-0x28(%ebp)
801026e0:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
801026e3:	0f 84 a7 00 00 00    	je     80102790 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
801026e9:	8b 45 d8             	mov    -0x28(%ebp),%eax
801026ec:	8b 40 58             	mov    0x58(%eax),%eax
801026ef:	39 c6                	cmp    %eax,%esi
801026f1:	0f 87 ba 00 00 00    	ja     801027b1 <readi+0xf1>
801026f7:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801026fa:	31 c9                	xor    %ecx,%ecx
801026fc:	89 da                	mov    %ebx,%edx
801026fe:	01 f2                	add    %esi,%edx
80102700:	0f 92 c1             	setb   %cl
80102703:	89 cf                	mov    %ecx,%edi
80102705:	0f 82 a6 00 00 00    	jb     801027b1 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
8010270b:	89 c1                	mov    %eax,%ecx
8010270d:	29 f1                	sub    %esi,%ecx
8010270f:	39 d0                	cmp    %edx,%eax
80102711:	0f 43 cb             	cmovae %ebx,%ecx
80102714:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80102717:	85 c9                	test   %ecx,%ecx
80102719:	74 67                	je     80102782 <readi+0xc2>
8010271b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010271f:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102720:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80102723:	89 f2                	mov    %esi,%edx
80102725:	c1 ea 09             	shr    $0x9,%edx
80102728:	89 d8                	mov    %ebx,%eax
8010272a:	e8 51 f9 ff ff       	call   80102080 <bmap>
8010272f:	83 ec 08             	sub    $0x8,%esp
80102732:	50                   	push   %eax
80102733:	ff 33                	push   (%ebx)
80102735:	e8 96 d9 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
8010273a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010273d:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102742:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80102744:	89 f0                	mov    %esi,%eax
80102746:	25 ff 01 00 00       	and    $0x1ff,%eax
8010274b:	29 fb                	sub    %edi,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
8010274d:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80102750:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80102752:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80102756:	39 d9                	cmp    %ebx,%ecx
80102758:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
8010275b:	83 c4 0c             	add    $0xc,%esp
8010275e:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
8010275f:	01 df                	add    %ebx,%edi
80102761:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80102763:	50                   	push   %eax
80102764:	ff 75 e0             	push   -0x20(%ebp)
80102767:	e8 e4 2e 00 00       	call   80105650 <memmove>
    brelse(bp);
8010276c:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010276f:	89 14 24             	mov    %edx,(%esp)
80102772:	e8 79 da ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80102777:	01 5d e0             	add    %ebx,-0x20(%ebp)
8010277a:	83 c4 10             	add    $0x10,%esp
8010277d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80102780:	77 9e                	ja     80102720 <readi+0x60>
  }
  return n;
80102782:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80102785:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102788:	5b                   	pop    %ebx
80102789:	5e                   	pop    %esi
8010278a:	5f                   	pop    %edi
8010278b:	5d                   	pop    %ebp
8010278c:	c3                   	ret    
8010278d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80102790:	0f bf 40 52          	movswl 0x52(%eax),%eax
80102794:	66 83 f8 09          	cmp    $0x9,%ax
80102798:	77 17                	ja     801027b1 <readi+0xf1>
8010279a:	8b 04 c5 00 13 11 80 	mov    -0x7feeed00(,%eax,8),%eax
801027a1:	85 c0                	test   %eax,%eax
801027a3:	74 0c                	je     801027b1 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
801027a5:	89 7d 10             	mov    %edi,0x10(%ebp)
}
801027a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801027ab:	5b                   	pop    %ebx
801027ac:	5e                   	pop    %esi
801027ad:	5f                   	pop    %edi
801027ae:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
801027af:	ff e0                	jmp    *%eax
      return -1;
801027b1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801027b6:	eb cd                	jmp    80102785 <readi+0xc5>
801027b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801027bf:	90                   	nop

801027c0 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
801027c0:	55                   	push   %ebp
801027c1:	89 e5                	mov    %esp,%ebp
801027c3:	57                   	push   %edi
801027c4:	56                   	push   %esi
801027c5:	53                   	push   %ebx
801027c6:	83 ec 1c             	sub    $0x1c,%esp
801027c9:	8b 45 08             	mov    0x8(%ebp),%eax
801027cc:	8b 75 0c             	mov    0xc(%ebp),%esi
801027cf:	8b 55 14             	mov    0x14(%ebp),%edx
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801027d2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
801027d7:	89 75 dc             	mov    %esi,-0x24(%ebp)
801027da:	89 45 d8             	mov    %eax,-0x28(%ebp)
801027dd:	8b 75 10             	mov    0x10(%ebp),%esi
801027e0:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(ip->type == T_DEV){
801027e3:	0f 84 b7 00 00 00    	je     801028a0 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
801027e9:	8b 45 d8             	mov    -0x28(%ebp),%eax
801027ec:	3b 70 58             	cmp    0x58(%eax),%esi
801027ef:	0f 87 e7 00 00 00    	ja     801028dc <writei+0x11c>
801027f5:	8b 7d e0             	mov    -0x20(%ebp),%edi
801027f8:	31 d2                	xor    %edx,%edx
801027fa:	89 f8                	mov    %edi,%eax
801027fc:	01 f0                	add    %esi,%eax
801027fe:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80102801:	3d 00 18 01 00       	cmp    $0x11800,%eax
80102806:	0f 87 d0 00 00 00    	ja     801028dc <writei+0x11c>
8010280c:	85 d2                	test   %edx,%edx
8010280e:	0f 85 c8 00 00 00    	jne    801028dc <writei+0x11c>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102814:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010281b:	85 ff                	test   %edi,%edi
8010281d:	74 72                	je     80102891 <writei+0xd1>
8010281f:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102820:	8b 7d d8             	mov    -0x28(%ebp),%edi
80102823:	89 f2                	mov    %esi,%edx
80102825:	c1 ea 09             	shr    $0x9,%edx
80102828:	89 f8                	mov    %edi,%eax
8010282a:	e8 51 f8 ff ff       	call   80102080 <bmap>
8010282f:	83 ec 08             	sub    $0x8,%esp
80102832:	50                   	push   %eax
80102833:	ff 37                	push   (%edi)
80102835:	e8 96 d8 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
8010283a:	b9 00 02 00 00       	mov    $0x200,%ecx
8010283f:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80102842:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102845:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80102847:	89 f0                	mov    %esi,%eax
80102849:	25 ff 01 00 00       	and    $0x1ff,%eax
8010284e:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80102850:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80102854:	39 d9                	cmp    %ebx,%ecx
80102856:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80102859:	83 c4 0c             	add    $0xc,%esp
8010285c:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
8010285d:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
8010285f:	ff 75 dc             	push   -0x24(%ebp)
80102862:	50                   	push   %eax
80102863:	e8 e8 2d 00 00       	call   80105650 <memmove>
    log_write(bp);
80102868:	89 3c 24             	mov    %edi,(%esp)
8010286b:	e8 00 13 00 00       	call   80103b70 <log_write>
    brelse(bp);
80102870:	89 3c 24             	mov    %edi,(%esp)
80102873:	e8 78 d9 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102878:	01 5d e4             	add    %ebx,-0x1c(%ebp)
8010287b:	83 c4 10             	add    $0x10,%esp
8010287e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102881:	01 5d dc             	add    %ebx,-0x24(%ebp)
80102884:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80102887:	77 97                	ja     80102820 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80102889:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010288c:	3b 70 58             	cmp    0x58(%eax),%esi
8010288f:	77 37                	ja     801028c8 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80102891:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80102894:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102897:	5b                   	pop    %ebx
80102898:	5e                   	pop    %esi
80102899:	5f                   	pop    %edi
8010289a:	5d                   	pop    %ebp
8010289b:	c3                   	ret    
8010289c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
801028a0:	0f bf 40 52          	movswl 0x52(%eax),%eax
801028a4:	66 83 f8 09          	cmp    $0x9,%ax
801028a8:	77 32                	ja     801028dc <writei+0x11c>
801028aa:	8b 04 c5 04 13 11 80 	mov    -0x7feeecfc(,%eax,8),%eax
801028b1:	85 c0                	test   %eax,%eax
801028b3:	74 27                	je     801028dc <writei+0x11c>
    return devsw[ip->major].write(ip, src, n);
801028b5:	89 55 10             	mov    %edx,0x10(%ebp)
}
801028b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801028bb:	5b                   	pop    %ebx
801028bc:	5e                   	pop    %esi
801028bd:	5f                   	pop    %edi
801028be:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
801028bf:	ff e0                	jmp    *%eax
801028c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
801028c8:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
801028cb:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
801028ce:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
801028d1:	50                   	push   %eax
801028d2:	e8 29 fa ff ff       	call   80102300 <iupdate>
801028d7:	83 c4 10             	add    $0x10,%esp
801028da:	eb b5                	jmp    80102891 <writei+0xd1>
      return -1;
801028dc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801028e1:	eb b1                	jmp    80102894 <writei+0xd4>
801028e3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801028ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801028f0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
801028f0:	55                   	push   %ebp
801028f1:	89 e5                	mov    %esp,%ebp
801028f3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
801028f6:	6a 0e                	push   $0xe
801028f8:	ff 75 0c             	push   0xc(%ebp)
801028fb:	ff 75 08             	push   0x8(%ebp)
801028fe:	e8 bd 2d 00 00       	call   801056c0 <strncmp>
}
80102903:	c9                   	leave  
80102904:	c3                   	ret    
80102905:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010290c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102910 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80102910:	55                   	push   %ebp
80102911:	89 e5                	mov    %esp,%ebp
80102913:	57                   	push   %edi
80102914:	56                   	push   %esi
80102915:	53                   	push   %ebx
80102916:	83 ec 1c             	sub    $0x1c,%esp
80102919:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
8010291c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80102921:	0f 85 85 00 00 00    	jne    801029ac <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80102927:	8b 53 58             	mov    0x58(%ebx),%edx
8010292a:	31 ff                	xor    %edi,%edi
8010292c:	8d 75 d8             	lea    -0x28(%ebp),%esi
8010292f:	85 d2                	test   %edx,%edx
80102931:	74 3e                	je     80102971 <dirlookup+0x61>
80102933:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102937:	90                   	nop
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102938:	6a 10                	push   $0x10
8010293a:	57                   	push   %edi
8010293b:	56                   	push   %esi
8010293c:	53                   	push   %ebx
8010293d:	e8 7e fd ff ff       	call   801026c0 <readi>
80102942:	83 c4 10             	add    $0x10,%esp
80102945:	83 f8 10             	cmp    $0x10,%eax
80102948:	75 55                	jne    8010299f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
8010294a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010294f:	74 18                	je     80102969 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80102951:	83 ec 04             	sub    $0x4,%esp
80102954:	8d 45 da             	lea    -0x26(%ebp),%eax
80102957:	6a 0e                	push   $0xe
80102959:	50                   	push   %eax
8010295a:	ff 75 0c             	push   0xc(%ebp)
8010295d:	e8 5e 2d 00 00       	call   801056c0 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80102962:	83 c4 10             	add    $0x10,%esp
80102965:	85 c0                	test   %eax,%eax
80102967:	74 17                	je     80102980 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80102969:	83 c7 10             	add    $0x10,%edi
8010296c:	3b 7b 58             	cmp    0x58(%ebx),%edi
8010296f:	72 c7                	jb     80102938 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80102971:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80102974:	31 c0                	xor    %eax,%eax
}
80102976:	5b                   	pop    %ebx
80102977:	5e                   	pop    %esi
80102978:	5f                   	pop    %edi
80102979:	5d                   	pop    %ebp
8010297a:	c3                   	ret    
8010297b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010297f:	90                   	nop
      if(poff)
80102980:	8b 45 10             	mov    0x10(%ebp),%eax
80102983:	85 c0                	test   %eax,%eax
80102985:	74 05                	je     8010298c <dirlookup+0x7c>
        *poff = off;
80102987:	8b 45 10             	mov    0x10(%ebp),%eax
8010298a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
8010298c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80102990:	8b 03                	mov    (%ebx),%eax
80102992:	e8 e9 f5 ff ff       	call   80101f80 <iget>
}
80102997:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010299a:	5b                   	pop    %ebx
8010299b:	5e                   	pop    %esi
8010299c:	5f                   	pop    %edi
8010299d:	5d                   	pop    %ebp
8010299e:	c3                   	ret    
      panic("dirlookup read");
8010299f:	83 ec 0c             	sub    $0xc,%esp
801029a2:	68 b9 83 10 80       	push   $0x801083b9
801029a7:	e8 d4 d9 ff ff       	call   80100380 <panic>
    panic("dirlookup not DIR");
801029ac:	83 ec 0c             	sub    $0xc,%esp
801029af:	68 a7 83 10 80       	push   $0x801083a7
801029b4:	e8 c7 d9 ff ff       	call   80100380 <panic>
801029b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801029c0 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
801029c0:	55                   	push   %ebp
801029c1:	89 e5                	mov    %esp,%ebp
801029c3:	57                   	push   %edi
801029c4:	56                   	push   %esi
801029c5:	53                   	push   %ebx
801029c6:	89 c3                	mov    %eax,%ebx
801029c8:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
801029cb:	80 38 2f             	cmpb   $0x2f,(%eax)
{
801029ce:	89 55 dc             	mov    %edx,-0x24(%ebp)
801029d1:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
801029d4:	0f 84 64 01 00 00    	je     80102b3e <namex+0x17e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
801029da:	e8 01 1c 00 00       	call   801045e0 <myproc>
  acquire(&icache.lock);
801029df:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
801029e2:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
801029e5:	68 60 13 11 80       	push   $0x80111360
801029ea:	e8 01 2b 00 00       	call   801054f0 <acquire>
  ip->ref++;
801029ef:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
801029f3:	c7 04 24 60 13 11 80 	movl   $0x80111360,(%esp)
801029fa:	e8 91 2a 00 00       	call   80105490 <release>
801029ff:	83 c4 10             	add    $0x10,%esp
80102a02:	eb 07                	jmp    80102a0b <namex+0x4b>
80102a04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80102a08:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80102a0b:	0f b6 03             	movzbl (%ebx),%eax
80102a0e:	3c 2f                	cmp    $0x2f,%al
80102a10:	74 f6                	je     80102a08 <namex+0x48>
  if(*path == 0)
80102a12:	84 c0                	test   %al,%al
80102a14:	0f 84 06 01 00 00    	je     80102b20 <namex+0x160>
  while(*path != '/' && *path != 0)
80102a1a:	0f b6 03             	movzbl (%ebx),%eax
80102a1d:	84 c0                	test   %al,%al
80102a1f:	0f 84 10 01 00 00    	je     80102b35 <namex+0x175>
80102a25:	89 df                	mov    %ebx,%edi
80102a27:	3c 2f                	cmp    $0x2f,%al
80102a29:	0f 84 06 01 00 00    	je     80102b35 <namex+0x175>
80102a2f:	90                   	nop
80102a30:	0f b6 47 01          	movzbl 0x1(%edi),%eax
    path++;
80102a34:	83 c7 01             	add    $0x1,%edi
  while(*path != '/' && *path != 0)
80102a37:	3c 2f                	cmp    $0x2f,%al
80102a39:	74 04                	je     80102a3f <namex+0x7f>
80102a3b:	84 c0                	test   %al,%al
80102a3d:	75 f1                	jne    80102a30 <namex+0x70>
  len = path - s;
80102a3f:	89 f8                	mov    %edi,%eax
80102a41:	29 d8                	sub    %ebx,%eax
  if(len >= DIRSIZ)
80102a43:	83 f8 0d             	cmp    $0xd,%eax
80102a46:	0f 8e ac 00 00 00    	jle    80102af8 <namex+0x138>
    memmove(name, s, DIRSIZ);
80102a4c:	83 ec 04             	sub    $0x4,%esp
80102a4f:	6a 0e                	push   $0xe
80102a51:	53                   	push   %ebx
    path++;
80102a52:	89 fb                	mov    %edi,%ebx
    memmove(name, s, DIRSIZ);
80102a54:	ff 75 e4             	push   -0x1c(%ebp)
80102a57:	e8 f4 2b 00 00       	call   80105650 <memmove>
80102a5c:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80102a5f:	80 3f 2f             	cmpb   $0x2f,(%edi)
80102a62:	75 0c                	jne    80102a70 <namex+0xb0>
80102a64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80102a68:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80102a6b:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80102a6e:	74 f8                	je     80102a68 <namex+0xa8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80102a70:	83 ec 0c             	sub    $0xc,%esp
80102a73:	56                   	push   %esi
80102a74:	e8 37 f9 ff ff       	call   801023b0 <ilock>
    if(ip->type != T_DIR){
80102a79:	83 c4 10             	add    $0x10,%esp
80102a7c:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80102a81:	0f 85 cd 00 00 00    	jne    80102b54 <namex+0x194>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80102a87:	8b 45 dc             	mov    -0x24(%ebp),%eax
80102a8a:	85 c0                	test   %eax,%eax
80102a8c:	74 09                	je     80102a97 <namex+0xd7>
80102a8e:	80 3b 00             	cmpb   $0x0,(%ebx)
80102a91:	0f 84 22 01 00 00    	je     80102bb9 <namex+0x1f9>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80102a97:	83 ec 04             	sub    $0x4,%esp
80102a9a:	6a 00                	push   $0x0
80102a9c:	ff 75 e4             	push   -0x1c(%ebp)
80102a9f:	56                   	push   %esi
80102aa0:	e8 6b fe ff ff       	call   80102910 <dirlookup>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102aa5:	8d 56 0c             	lea    0xc(%esi),%edx
    if((next = dirlookup(ip, name, 0)) == 0){
80102aa8:	83 c4 10             	add    $0x10,%esp
80102aab:	89 c7                	mov    %eax,%edi
80102aad:	85 c0                	test   %eax,%eax
80102aaf:	0f 84 e1 00 00 00    	je     80102b96 <namex+0x1d6>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102ab5:	83 ec 0c             	sub    $0xc,%esp
80102ab8:	89 55 e0             	mov    %edx,-0x20(%ebp)
80102abb:	52                   	push   %edx
80102abc:	e8 0f 28 00 00       	call   801052d0 <holdingsleep>
80102ac1:	83 c4 10             	add    $0x10,%esp
80102ac4:	85 c0                	test   %eax,%eax
80102ac6:	0f 84 30 01 00 00    	je     80102bfc <namex+0x23c>
80102acc:	8b 56 08             	mov    0x8(%esi),%edx
80102acf:	85 d2                	test   %edx,%edx
80102ad1:	0f 8e 25 01 00 00    	jle    80102bfc <namex+0x23c>
  releasesleep(&ip->lock);
80102ad7:	8b 55 e0             	mov    -0x20(%ebp),%edx
80102ada:	83 ec 0c             	sub    $0xc,%esp
80102add:	52                   	push   %edx
80102ade:	e8 ad 27 00 00       	call   80105290 <releasesleep>
  iput(ip);
80102ae3:	89 34 24             	mov    %esi,(%esp)
80102ae6:	89 fe                	mov    %edi,%esi
80102ae8:	e8 f3 f9 ff ff       	call   801024e0 <iput>
80102aed:	83 c4 10             	add    $0x10,%esp
80102af0:	e9 16 ff ff ff       	jmp    80102a0b <namex+0x4b>
80102af5:	8d 76 00             	lea    0x0(%esi),%esi
    name[len] = 0;
80102af8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80102afb:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    memmove(name, s, len);
80102afe:	83 ec 04             	sub    $0x4,%esp
80102b01:	89 55 e0             	mov    %edx,-0x20(%ebp)
80102b04:	50                   	push   %eax
80102b05:	53                   	push   %ebx
    name[len] = 0;
80102b06:	89 fb                	mov    %edi,%ebx
    memmove(name, s, len);
80102b08:	ff 75 e4             	push   -0x1c(%ebp)
80102b0b:	e8 40 2b 00 00       	call   80105650 <memmove>
    name[len] = 0;
80102b10:	8b 55 e0             	mov    -0x20(%ebp),%edx
80102b13:	83 c4 10             	add    $0x10,%esp
80102b16:	c6 02 00             	movb   $0x0,(%edx)
80102b19:	e9 41 ff ff ff       	jmp    80102a5f <namex+0x9f>
80102b1e:	66 90                	xchg   %ax,%ax
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80102b20:	8b 45 dc             	mov    -0x24(%ebp),%eax
80102b23:	85 c0                	test   %eax,%eax
80102b25:	0f 85 be 00 00 00    	jne    80102be9 <namex+0x229>
    iput(ip);
    return 0;
  }
  return ip;
}
80102b2b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b2e:	89 f0                	mov    %esi,%eax
80102b30:	5b                   	pop    %ebx
80102b31:	5e                   	pop    %esi
80102b32:	5f                   	pop    %edi
80102b33:	5d                   	pop    %ebp
80102b34:	c3                   	ret    
  while(*path != '/' && *path != 0)
80102b35:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80102b38:	89 df                	mov    %ebx,%edi
80102b3a:	31 c0                	xor    %eax,%eax
80102b3c:	eb c0                	jmp    80102afe <namex+0x13e>
    ip = iget(ROOTDEV, ROOTINO);
80102b3e:	ba 01 00 00 00       	mov    $0x1,%edx
80102b43:	b8 01 00 00 00       	mov    $0x1,%eax
80102b48:	e8 33 f4 ff ff       	call   80101f80 <iget>
80102b4d:	89 c6                	mov    %eax,%esi
80102b4f:	e9 b7 fe ff ff       	jmp    80102a0b <namex+0x4b>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102b54:	83 ec 0c             	sub    $0xc,%esp
80102b57:	8d 5e 0c             	lea    0xc(%esi),%ebx
80102b5a:	53                   	push   %ebx
80102b5b:	e8 70 27 00 00       	call   801052d0 <holdingsleep>
80102b60:	83 c4 10             	add    $0x10,%esp
80102b63:	85 c0                	test   %eax,%eax
80102b65:	0f 84 91 00 00 00    	je     80102bfc <namex+0x23c>
80102b6b:	8b 46 08             	mov    0x8(%esi),%eax
80102b6e:	85 c0                	test   %eax,%eax
80102b70:	0f 8e 86 00 00 00    	jle    80102bfc <namex+0x23c>
  releasesleep(&ip->lock);
80102b76:	83 ec 0c             	sub    $0xc,%esp
80102b79:	53                   	push   %ebx
80102b7a:	e8 11 27 00 00       	call   80105290 <releasesleep>
  iput(ip);
80102b7f:	89 34 24             	mov    %esi,(%esp)
      return 0;
80102b82:	31 f6                	xor    %esi,%esi
  iput(ip);
80102b84:	e8 57 f9 ff ff       	call   801024e0 <iput>
      return 0;
80102b89:	83 c4 10             	add    $0x10,%esp
}
80102b8c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b8f:	89 f0                	mov    %esi,%eax
80102b91:	5b                   	pop    %ebx
80102b92:	5e                   	pop    %esi
80102b93:	5f                   	pop    %edi
80102b94:	5d                   	pop    %ebp
80102b95:	c3                   	ret    
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102b96:	83 ec 0c             	sub    $0xc,%esp
80102b99:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80102b9c:	52                   	push   %edx
80102b9d:	e8 2e 27 00 00       	call   801052d0 <holdingsleep>
80102ba2:	83 c4 10             	add    $0x10,%esp
80102ba5:	85 c0                	test   %eax,%eax
80102ba7:	74 53                	je     80102bfc <namex+0x23c>
80102ba9:	8b 4e 08             	mov    0x8(%esi),%ecx
80102bac:	85 c9                	test   %ecx,%ecx
80102bae:	7e 4c                	jle    80102bfc <namex+0x23c>
  releasesleep(&ip->lock);
80102bb0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80102bb3:	83 ec 0c             	sub    $0xc,%esp
80102bb6:	52                   	push   %edx
80102bb7:	eb c1                	jmp    80102b7a <namex+0x1ba>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102bb9:	83 ec 0c             	sub    $0xc,%esp
80102bbc:	8d 5e 0c             	lea    0xc(%esi),%ebx
80102bbf:	53                   	push   %ebx
80102bc0:	e8 0b 27 00 00       	call   801052d0 <holdingsleep>
80102bc5:	83 c4 10             	add    $0x10,%esp
80102bc8:	85 c0                	test   %eax,%eax
80102bca:	74 30                	je     80102bfc <namex+0x23c>
80102bcc:	8b 7e 08             	mov    0x8(%esi),%edi
80102bcf:	85 ff                	test   %edi,%edi
80102bd1:	7e 29                	jle    80102bfc <namex+0x23c>
  releasesleep(&ip->lock);
80102bd3:	83 ec 0c             	sub    $0xc,%esp
80102bd6:	53                   	push   %ebx
80102bd7:	e8 b4 26 00 00       	call   80105290 <releasesleep>
}
80102bdc:	83 c4 10             	add    $0x10,%esp
}
80102bdf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102be2:	89 f0                	mov    %esi,%eax
80102be4:	5b                   	pop    %ebx
80102be5:	5e                   	pop    %esi
80102be6:	5f                   	pop    %edi
80102be7:	5d                   	pop    %ebp
80102be8:	c3                   	ret    
    iput(ip);
80102be9:	83 ec 0c             	sub    $0xc,%esp
80102bec:	56                   	push   %esi
    return 0;
80102bed:	31 f6                	xor    %esi,%esi
    iput(ip);
80102bef:	e8 ec f8 ff ff       	call   801024e0 <iput>
    return 0;
80102bf4:	83 c4 10             	add    $0x10,%esp
80102bf7:	e9 2f ff ff ff       	jmp    80102b2b <namex+0x16b>
    panic("iunlock");
80102bfc:	83 ec 0c             	sub    $0xc,%esp
80102bff:	68 9f 83 10 80       	push   $0x8010839f
80102c04:	e8 77 d7 ff ff       	call   80100380 <panic>
80102c09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102c10 <dirlink>:
{
80102c10:	55                   	push   %ebp
80102c11:	89 e5                	mov    %esp,%ebp
80102c13:	57                   	push   %edi
80102c14:	56                   	push   %esi
80102c15:	53                   	push   %ebx
80102c16:	83 ec 20             	sub    $0x20,%esp
80102c19:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80102c1c:	6a 00                	push   $0x0
80102c1e:	ff 75 0c             	push   0xc(%ebp)
80102c21:	53                   	push   %ebx
80102c22:	e8 e9 fc ff ff       	call   80102910 <dirlookup>
80102c27:	83 c4 10             	add    $0x10,%esp
80102c2a:	85 c0                	test   %eax,%eax
80102c2c:	75 67                	jne    80102c95 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80102c2e:	8b 7b 58             	mov    0x58(%ebx),%edi
80102c31:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102c34:	85 ff                	test   %edi,%edi
80102c36:	74 29                	je     80102c61 <dirlink+0x51>
80102c38:	31 ff                	xor    %edi,%edi
80102c3a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102c3d:	eb 09                	jmp    80102c48 <dirlink+0x38>
80102c3f:	90                   	nop
80102c40:	83 c7 10             	add    $0x10,%edi
80102c43:	3b 7b 58             	cmp    0x58(%ebx),%edi
80102c46:	73 19                	jae    80102c61 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102c48:	6a 10                	push   $0x10
80102c4a:	57                   	push   %edi
80102c4b:	56                   	push   %esi
80102c4c:	53                   	push   %ebx
80102c4d:	e8 6e fa ff ff       	call   801026c0 <readi>
80102c52:	83 c4 10             	add    $0x10,%esp
80102c55:	83 f8 10             	cmp    $0x10,%eax
80102c58:	75 4e                	jne    80102ca8 <dirlink+0x98>
    if(de.inum == 0)
80102c5a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80102c5f:	75 df                	jne    80102c40 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80102c61:	83 ec 04             	sub    $0x4,%esp
80102c64:	8d 45 da             	lea    -0x26(%ebp),%eax
80102c67:	6a 0e                	push   $0xe
80102c69:	ff 75 0c             	push   0xc(%ebp)
80102c6c:	50                   	push   %eax
80102c6d:	e8 9e 2a 00 00       	call   80105710 <strncpy>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102c72:	6a 10                	push   $0x10
  de.inum = inum;
80102c74:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102c77:	57                   	push   %edi
80102c78:	56                   	push   %esi
80102c79:	53                   	push   %ebx
  de.inum = inum;
80102c7a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102c7e:	e8 3d fb ff ff       	call   801027c0 <writei>
80102c83:	83 c4 20             	add    $0x20,%esp
80102c86:	83 f8 10             	cmp    $0x10,%eax
80102c89:	75 2a                	jne    80102cb5 <dirlink+0xa5>
  return 0;
80102c8b:	31 c0                	xor    %eax,%eax
}
80102c8d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102c90:	5b                   	pop    %ebx
80102c91:	5e                   	pop    %esi
80102c92:	5f                   	pop    %edi
80102c93:	5d                   	pop    %ebp
80102c94:	c3                   	ret    
    iput(ip);
80102c95:	83 ec 0c             	sub    $0xc,%esp
80102c98:	50                   	push   %eax
80102c99:	e8 42 f8 ff ff       	call   801024e0 <iput>
    return -1;
80102c9e:	83 c4 10             	add    $0x10,%esp
80102ca1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102ca6:	eb e5                	jmp    80102c8d <dirlink+0x7d>
      panic("dirlink read");
80102ca8:	83 ec 0c             	sub    $0xc,%esp
80102cab:	68 c8 83 10 80       	push   $0x801083c8
80102cb0:	e8 cb d6 ff ff       	call   80100380 <panic>
    panic("dirlink");
80102cb5:	83 ec 0c             	sub    $0xc,%esp
80102cb8:	68 ae 8b 10 80       	push   $0x80108bae
80102cbd:	e8 be d6 ff ff       	call   80100380 <panic>
80102cc2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102cc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102cd0 <namei>:

struct inode*
namei(char *path)
{
80102cd0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102cd1:	31 d2                	xor    %edx,%edx
{
80102cd3:	89 e5                	mov    %esp,%ebp
80102cd5:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80102cd8:	8b 45 08             	mov    0x8(%ebp),%eax
80102cdb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80102cde:	e8 dd fc ff ff       	call   801029c0 <namex>
}
80102ce3:	c9                   	leave  
80102ce4:	c3                   	ret    
80102ce5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102cec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102cf0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102cf0:	55                   	push   %ebp
  return namex(path, 1, name);
80102cf1:	ba 01 00 00 00       	mov    $0x1,%edx
{
80102cf6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102cf8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102cfb:	8b 45 08             	mov    0x8(%ebp),%eax
}
80102cfe:	5d                   	pop    %ebp
  return namex(path, 1, name);
80102cff:	e9 bc fc ff ff       	jmp    801029c0 <namex>
80102d04:	66 90                	xchg   %ax,%ax
80102d06:	66 90                	xchg   %ax,%ax
80102d08:	66 90                	xchg   %ax,%ax
80102d0a:	66 90                	xchg   %ax,%ax
80102d0c:	66 90                	xchg   %ax,%ax
80102d0e:	66 90                	xchg   %ax,%ax

80102d10 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102d10:	55                   	push   %ebp
80102d11:	89 e5                	mov    %esp,%ebp
80102d13:	57                   	push   %edi
80102d14:	56                   	push   %esi
80102d15:	53                   	push   %ebx
80102d16:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80102d19:	85 c0                	test   %eax,%eax
80102d1b:	0f 84 b4 00 00 00    	je     80102dd5 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102d21:	8b 70 08             	mov    0x8(%eax),%esi
80102d24:	89 c3                	mov    %eax,%ebx
80102d26:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
80102d2c:	0f 87 96 00 00 00    	ja     80102dc8 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d32:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102d37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d3e:	66 90                	xchg   %ax,%ax
80102d40:	89 ca                	mov    %ecx,%edx
80102d42:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102d43:	83 e0 c0             	and    $0xffffffc0,%eax
80102d46:	3c 40                	cmp    $0x40,%al
80102d48:	75 f6                	jne    80102d40 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102d4a:	31 ff                	xor    %edi,%edi
80102d4c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102d51:	89 f8                	mov    %edi,%eax
80102d53:	ee                   	out    %al,(%dx)
80102d54:	b8 01 00 00 00       	mov    $0x1,%eax
80102d59:	ba f2 01 00 00       	mov    $0x1f2,%edx
80102d5e:	ee                   	out    %al,(%dx)
80102d5f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102d64:	89 f0                	mov    %esi,%eax
80102d66:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102d67:	89 f0                	mov    %esi,%eax
80102d69:	ba f4 01 00 00       	mov    $0x1f4,%edx
80102d6e:	c1 f8 08             	sar    $0x8,%eax
80102d71:	ee                   	out    %al,(%dx)
80102d72:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102d77:	89 f8                	mov    %edi,%eax
80102d79:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80102d7a:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
80102d7e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102d83:	c1 e0 04             	shl    $0x4,%eax
80102d86:	83 e0 10             	and    $0x10,%eax
80102d89:	83 c8 e0             	or     $0xffffffe0,%eax
80102d8c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80102d8d:	f6 03 04             	testb  $0x4,(%ebx)
80102d90:	75 16                	jne    80102da8 <idestart+0x98>
80102d92:	b8 20 00 00 00       	mov    $0x20,%eax
80102d97:	89 ca                	mov    %ecx,%edx
80102d99:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80102d9a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d9d:	5b                   	pop    %ebx
80102d9e:	5e                   	pop    %esi
80102d9f:	5f                   	pop    %edi
80102da0:	5d                   	pop    %ebp
80102da1:	c3                   	ret    
80102da2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102da8:	b8 30 00 00 00       	mov    $0x30,%eax
80102dad:	89 ca                	mov    %ecx,%edx
80102daf:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102db0:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102db5:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102db8:	ba f0 01 00 00       	mov    $0x1f0,%edx
80102dbd:	fc                   	cld    
80102dbe:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102dc0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102dc3:	5b                   	pop    %ebx
80102dc4:	5e                   	pop    %esi
80102dc5:	5f                   	pop    %edi
80102dc6:	5d                   	pop    %ebp
80102dc7:	c3                   	ret    
    panic("incorrect blockno");
80102dc8:	83 ec 0c             	sub    $0xc,%esp
80102dcb:	68 34 84 10 80       	push   $0x80108434
80102dd0:	e8 ab d5 ff ff       	call   80100380 <panic>
    panic("idestart");
80102dd5:	83 ec 0c             	sub    $0xc,%esp
80102dd8:	68 2b 84 10 80       	push   $0x8010842b
80102ddd:	e8 9e d5 ff ff       	call   80100380 <panic>
80102de2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102df0 <ideinit>:
{
80102df0:	55                   	push   %ebp
80102df1:	89 e5                	mov    %esp,%ebp
80102df3:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102df6:	68 46 84 10 80       	push   $0x80108446
80102dfb:	68 00 30 11 80       	push   $0x80113000
80102e00:	e8 1b 25 00 00       	call   80105320 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102e05:	58                   	pop    %eax
80102e06:	a1 84 31 11 80       	mov    0x80113184,%eax
80102e0b:	5a                   	pop    %edx
80102e0c:	83 e8 01             	sub    $0x1,%eax
80102e0f:	50                   	push   %eax
80102e10:	6a 0e                	push   $0xe
80102e12:	e8 99 02 00 00       	call   801030b0 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102e17:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e1a:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102e1f:	90                   	nop
80102e20:	ec                   	in     (%dx),%al
80102e21:	83 e0 c0             	and    $0xffffffc0,%eax
80102e24:	3c 40                	cmp    $0x40,%al
80102e26:	75 f8                	jne    80102e20 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e28:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80102e2d:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102e32:	ee                   	out    %al,(%dx)
80102e33:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e38:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102e3d:	eb 06                	jmp    80102e45 <ideinit+0x55>
80102e3f:	90                   	nop
  for(i=0; i<1000; i++){
80102e40:	83 e9 01             	sub    $0x1,%ecx
80102e43:	74 0f                	je     80102e54 <ideinit+0x64>
80102e45:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102e46:	84 c0                	test   %al,%al
80102e48:	74 f6                	je     80102e40 <ideinit+0x50>
      havedisk1 = 1;
80102e4a:	c7 05 e0 2f 11 80 01 	movl   $0x1,0x80112fe0
80102e51:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e54:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102e59:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102e5e:	ee                   	out    %al,(%dx)
}
80102e5f:	c9                   	leave  
80102e60:	c3                   	ret    
80102e61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e6f:	90                   	nop

80102e70 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102e70:	55                   	push   %ebp
80102e71:	89 e5                	mov    %esp,%ebp
80102e73:	57                   	push   %edi
80102e74:	56                   	push   %esi
80102e75:	53                   	push   %ebx
80102e76:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102e79:	68 00 30 11 80       	push   $0x80113000
80102e7e:	e8 6d 26 00 00       	call   801054f0 <acquire>

  if((b = idequeue) == 0){
80102e83:	8b 1d e4 2f 11 80    	mov    0x80112fe4,%ebx
80102e89:	83 c4 10             	add    $0x10,%esp
80102e8c:	85 db                	test   %ebx,%ebx
80102e8e:	74 63                	je     80102ef3 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102e90:	8b 43 58             	mov    0x58(%ebx),%eax
80102e93:	a3 e4 2f 11 80       	mov    %eax,0x80112fe4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102e98:	8b 33                	mov    (%ebx),%esi
80102e9a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102ea0:	75 2f                	jne    80102ed1 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ea2:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102ea7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102eae:	66 90                	xchg   %ax,%ax
80102eb0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102eb1:	89 c1                	mov    %eax,%ecx
80102eb3:	83 e1 c0             	and    $0xffffffc0,%ecx
80102eb6:	80 f9 40             	cmp    $0x40,%cl
80102eb9:	75 f5                	jne    80102eb0 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
80102ebb:	a8 21                	test   $0x21,%al
80102ebd:	75 12                	jne    80102ed1 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
80102ebf:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102ec2:	b9 80 00 00 00       	mov    $0x80,%ecx
80102ec7:	ba f0 01 00 00       	mov    $0x1f0,%edx
80102ecc:	fc                   	cld    
80102ecd:	f3 6d                	rep insl (%dx),%es:(%edi)

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
80102ecf:	8b 33                	mov    (%ebx),%esi
  b->flags &= ~B_DIRTY;
80102ed1:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102ed4:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102ed7:	83 ce 02             	or     $0x2,%esi
80102eda:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
80102edc:	53                   	push   %ebx
80102edd:	e8 2e 20 00 00       	call   80104f10 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102ee2:	a1 e4 2f 11 80       	mov    0x80112fe4,%eax
80102ee7:	83 c4 10             	add    $0x10,%esp
80102eea:	85 c0                	test   %eax,%eax
80102eec:	74 05                	je     80102ef3 <ideintr+0x83>
    idestart(idequeue);
80102eee:	e8 1d fe ff ff       	call   80102d10 <idestart>
    release(&idelock);
80102ef3:	83 ec 0c             	sub    $0xc,%esp
80102ef6:	68 00 30 11 80       	push   $0x80113000
80102efb:	e8 90 25 00 00       	call   80105490 <release>

  release(&idelock);
}
80102f00:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102f03:	5b                   	pop    %ebx
80102f04:	5e                   	pop    %esi
80102f05:	5f                   	pop    %edi
80102f06:	5d                   	pop    %ebp
80102f07:	c3                   	ret    
80102f08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f0f:	90                   	nop

80102f10 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102f10:	55                   	push   %ebp
80102f11:	89 e5                	mov    %esp,%ebp
80102f13:	53                   	push   %ebx
80102f14:	83 ec 10             	sub    $0x10,%esp
80102f17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
80102f1a:	8d 43 0c             	lea    0xc(%ebx),%eax
80102f1d:	50                   	push   %eax
80102f1e:	e8 ad 23 00 00       	call   801052d0 <holdingsleep>
80102f23:	83 c4 10             	add    $0x10,%esp
80102f26:	85 c0                	test   %eax,%eax
80102f28:	0f 84 c3 00 00 00    	je     80102ff1 <iderw+0xe1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
80102f2e:	8b 03                	mov    (%ebx),%eax
80102f30:	83 e0 06             	and    $0x6,%eax
80102f33:	83 f8 02             	cmp    $0x2,%eax
80102f36:	0f 84 a8 00 00 00    	je     80102fe4 <iderw+0xd4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
80102f3c:	8b 53 04             	mov    0x4(%ebx),%edx
80102f3f:	85 d2                	test   %edx,%edx
80102f41:	74 0d                	je     80102f50 <iderw+0x40>
80102f43:	a1 e0 2f 11 80       	mov    0x80112fe0,%eax
80102f48:	85 c0                	test   %eax,%eax
80102f4a:	0f 84 87 00 00 00    	je     80102fd7 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102f50:	83 ec 0c             	sub    $0xc,%esp
80102f53:	68 00 30 11 80       	push   $0x80113000
80102f58:	e8 93 25 00 00       	call   801054f0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102f5d:	a1 e4 2f 11 80       	mov    0x80112fe4,%eax
  b->qnext = 0;
80102f62:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102f69:	83 c4 10             	add    $0x10,%esp
80102f6c:	85 c0                	test   %eax,%eax
80102f6e:	74 60                	je     80102fd0 <iderw+0xc0>
80102f70:	89 c2                	mov    %eax,%edx
80102f72:	8b 40 58             	mov    0x58(%eax),%eax
80102f75:	85 c0                	test   %eax,%eax
80102f77:	75 f7                	jne    80102f70 <iderw+0x60>
80102f79:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102f7c:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102f7e:	39 1d e4 2f 11 80    	cmp    %ebx,0x80112fe4
80102f84:	74 3a                	je     80102fc0 <iderw+0xb0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102f86:	8b 03                	mov    (%ebx),%eax
80102f88:	83 e0 06             	and    $0x6,%eax
80102f8b:	83 f8 02             	cmp    $0x2,%eax
80102f8e:	74 1b                	je     80102fab <iderw+0x9b>
    sleep(b, &idelock);
80102f90:	83 ec 08             	sub    $0x8,%esp
80102f93:	68 00 30 11 80       	push   $0x80113000
80102f98:	53                   	push   %ebx
80102f99:	e8 b2 1e 00 00       	call   80104e50 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102f9e:	8b 03                	mov    (%ebx),%eax
80102fa0:	83 c4 10             	add    $0x10,%esp
80102fa3:	83 e0 06             	and    $0x6,%eax
80102fa6:	83 f8 02             	cmp    $0x2,%eax
80102fa9:	75 e5                	jne    80102f90 <iderw+0x80>
  }


  release(&idelock);
80102fab:	c7 45 08 00 30 11 80 	movl   $0x80113000,0x8(%ebp)
}
80102fb2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102fb5:	c9                   	leave  
  release(&idelock);
80102fb6:	e9 d5 24 00 00       	jmp    80105490 <release>
80102fbb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102fbf:	90                   	nop
    idestart(b);
80102fc0:	89 d8                	mov    %ebx,%eax
80102fc2:	e8 49 fd ff ff       	call   80102d10 <idestart>
80102fc7:	eb bd                	jmp    80102f86 <iderw+0x76>
80102fc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102fd0:	ba e4 2f 11 80       	mov    $0x80112fe4,%edx
80102fd5:	eb a5                	jmp    80102f7c <iderw+0x6c>
    panic("iderw: ide disk 1 not present");
80102fd7:	83 ec 0c             	sub    $0xc,%esp
80102fda:	68 75 84 10 80       	push   $0x80108475
80102fdf:	e8 9c d3 ff ff       	call   80100380 <panic>
    panic("iderw: nothing to do");
80102fe4:	83 ec 0c             	sub    $0xc,%esp
80102fe7:	68 60 84 10 80       	push   $0x80108460
80102fec:	e8 8f d3 ff ff       	call   80100380 <panic>
    panic("iderw: buf not locked");
80102ff1:	83 ec 0c             	sub    $0xc,%esp
80102ff4:	68 4a 84 10 80       	push   $0x8010844a
80102ff9:	e8 82 d3 ff ff       	call   80100380 <panic>
80102ffe:	66 90                	xchg   %ax,%ax

80103000 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80103000:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80103001:	c7 05 34 30 11 80 00 	movl   $0xfec00000,0x80113034
80103008:	00 c0 fe 
{
8010300b:	89 e5                	mov    %esp,%ebp
8010300d:	56                   	push   %esi
8010300e:	53                   	push   %ebx
  ioapic->reg = reg;
8010300f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80103016:	00 00 00 
  return ioapic->data;
80103019:	8b 15 34 30 11 80    	mov    0x80113034,%edx
8010301f:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
80103022:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80103028:	8b 0d 34 30 11 80    	mov    0x80113034,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010302e:	0f b6 15 80 31 11 80 	movzbl 0x80113180,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80103035:	c1 ee 10             	shr    $0x10,%esi
80103038:	89 f0                	mov    %esi,%eax
8010303a:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
8010303d:	8b 41 10             	mov    0x10(%ecx),%eax
  id = ioapicread(REG_ID) >> 24;
80103040:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80103043:	39 c2                	cmp    %eax,%edx
80103045:	74 16                	je     8010305d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80103047:	83 ec 0c             	sub    $0xc,%esp
8010304a:	68 94 84 10 80       	push   $0x80108494
8010304f:	e8 3c d7 ff ff       	call   80100790 <cprintf>
  ioapic->reg = reg;
80103054:	8b 0d 34 30 11 80    	mov    0x80113034,%ecx
8010305a:	83 c4 10             	add    $0x10,%esp
8010305d:	83 c6 21             	add    $0x21,%esi
{
80103060:	ba 10 00 00 00       	mov    $0x10,%edx
80103065:	b8 20 00 00 00       	mov    $0x20,%eax
8010306a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  ioapic->reg = reg;
80103070:	89 11                	mov    %edx,(%ecx)

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80103072:	89 c3                	mov    %eax,%ebx
  ioapic->data = data;
80103074:	8b 0d 34 30 11 80    	mov    0x80113034,%ecx
  for(i = 0; i <= maxintr; i++){
8010307a:	83 c0 01             	add    $0x1,%eax
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
8010307d:	81 cb 00 00 01 00    	or     $0x10000,%ebx
  ioapic->data = data;
80103083:	89 59 10             	mov    %ebx,0x10(%ecx)
  ioapic->reg = reg;
80103086:	8d 5a 01             	lea    0x1(%edx),%ebx
  for(i = 0; i <= maxintr; i++){
80103089:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
8010308c:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
8010308e:	8b 0d 34 30 11 80    	mov    0x80113034,%ecx
80103094:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
8010309b:	39 f0                	cmp    %esi,%eax
8010309d:	75 d1                	jne    80103070 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010309f:	8d 65 f8             	lea    -0x8(%ebp),%esp
801030a2:	5b                   	pop    %ebx
801030a3:	5e                   	pop    %esi
801030a4:	5d                   	pop    %ebp
801030a5:	c3                   	ret    
801030a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801030ad:	8d 76 00             	lea    0x0(%esi),%esi

801030b0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801030b0:	55                   	push   %ebp
  ioapic->reg = reg;
801030b1:	8b 0d 34 30 11 80    	mov    0x80113034,%ecx
{
801030b7:	89 e5                	mov    %esp,%ebp
801030b9:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801030bc:	8d 50 20             	lea    0x20(%eax),%edx
801030bf:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
801030c3:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801030c5:	8b 0d 34 30 11 80    	mov    0x80113034,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801030cb:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801030ce:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801030d1:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
801030d4:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801030d6:	a1 34 30 11 80       	mov    0x80113034,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801030db:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
801030de:	89 50 10             	mov    %edx,0x10(%eax)
}
801030e1:	5d                   	pop    %ebp
801030e2:	c3                   	ret    
801030e3:	66 90                	xchg   %ax,%ax
801030e5:	66 90                	xchg   %ax,%ax
801030e7:	66 90                	xchg   %ax,%ax
801030e9:	66 90                	xchg   %ax,%ax
801030eb:	66 90                	xchg   %ax,%ax
801030ed:	66 90                	xchg   %ax,%ax
801030ef:	90                   	nop

801030f0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801030f0:	55                   	push   %ebp
801030f1:	89 e5                	mov    %esp,%ebp
801030f3:	53                   	push   %ebx
801030f4:	83 ec 04             	sub    $0x4,%esp
801030f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801030fa:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80103100:	75 76                	jne    80103178 <kfree+0x88>
80103102:	81 fb d0 75 11 80    	cmp    $0x801175d0,%ebx
80103108:	72 6e                	jb     80103178 <kfree+0x88>
8010310a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80103110:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80103115:	77 61                	ja     80103178 <kfree+0x88>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80103117:	83 ec 04             	sub    $0x4,%esp
8010311a:	68 00 10 00 00       	push   $0x1000
8010311f:	6a 01                	push   $0x1
80103121:	53                   	push   %ebx
80103122:	e8 89 24 00 00       	call   801055b0 <memset>

  if(kmem.use_lock)
80103127:	8b 15 74 30 11 80    	mov    0x80113074,%edx
8010312d:	83 c4 10             	add    $0x10,%esp
80103130:	85 d2                	test   %edx,%edx
80103132:	75 1c                	jne    80103150 <kfree+0x60>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80103134:	a1 78 30 11 80       	mov    0x80113078,%eax
80103139:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010313b:	a1 74 30 11 80       	mov    0x80113074,%eax
  kmem.freelist = r;
80103140:	89 1d 78 30 11 80    	mov    %ebx,0x80113078
  if(kmem.use_lock)
80103146:	85 c0                	test   %eax,%eax
80103148:	75 1e                	jne    80103168 <kfree+0x78>
    release(&kmem.lock);
}
8010314a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010314d:	c9                   	leave  
8010314e:	c3                   	ret    
8010314f:	90                   	nop
    acquire(&kmem.lock);
80103150:	83 ec 0c             	sub    $0xc,%esp
80103153:	68 40 30 11 80       	push   $0x80113040
80103158:	e8 93 23 00 00       	call   801054f0 <acquire>
8010315d:	83 c4 10             	add    $0x10,%esp
80103160:	eb d2                	jmp    80103134 <kfree+0x44>
80103162:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80103168:	c7 45 08 40 30 11 80 	movl   $0x80113040,0x8(%ebp)
}
8010316f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103172:	c9                   	leave  
    release(&kmem.lock);
80103173:	e9 18 23 00 00       	jmp    80105490 <release>
    panic("kfree");
80103178:	83 ec 0c             	sub    $0xc,%esp
8010317b:	68 c6 84 10 80       	push   $0x801084c6
80103180:	e8 fb d1 ff ff       	call   80100380 <panic>
80103185:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010318c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103190 <freerange>:
{
80103190:	55                   	push   %ebp
80103191:	89 e5                	mov    %esp,%ebp
80103193:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
80103194:	8b 45 08             	mov    0x8(%ebp),%eax
{
80103197:	8b 75 0c             	mov    0xc(%ebp),%esi
8010319a:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
8010319b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801031a1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801031a7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801031ad:	39 de                	cmp    %ebx,%esi
801031af:	72 23                	jb     801031d4 <freerange+0x44>
801031b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801031b8:	83 ec 0c             	sub    $0xc,%esp
801031bb:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801031c1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801031c7:	50                   	push   %eax
801031c8:	e8 23 ff ff ff       	call   801030f0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801031cd:	83 c4 10             	add    $0x10,%esp
801031d0:	39 f3                	cmp    %esi,%ebx
801031d2:	76 e4                	jbe    801031b8 <freerange+0x28>
}
801031d4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801031d7:	5b                   	pop    %ebx
801031d8:	5e                   	pop    %esi
801031d9:	5d                   	pop    %ebp
801031da:	c3                   	ret    
801031db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801031df:	90                   	nop

801031e0 <kinit2>:
{
801031e0:	55                   	push   %ebp
801031e1:	89 e5                	mov    %esp,%ebp
801031e3:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
801031e4:	8b 45 08             	mov    0x8(%ebp),%eax
{
801031e7:	8b 75 0c             	mov    0xc(%ebp),%esi
801031ea:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801031eb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801031f1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801031f7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801031fd:	39 de                	cmp    %ebx,%esi
801031ff:	72 23                	jb     80103224 <kinit2+0x44>
80103201:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80103208:	83 ec 0c             	sub    $0xc,%esp
8010320b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103211:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80103217:	50                   	push   %eax
80103218:	e8 d3 fe ff ff       	call   801030f0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010321d:	83 c4 10             	add    $0x10,%esp
80103220:	39 de                	cmp    %ebx,%esi
80103222:	73 e4                	jae    80103208 <kinit2+0x28>
  kmem.use_lock = 1;
80103224:	c7 05 74 30 11 80 01 	movl   $0x1,0x80113074
8010322b:	00 00 00 
}
8010322e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103231:	5b                   	pop    %ebx
80103232:	5e                   	pop    %esi
80103233:	5d                   	pop    %ebp
80103234:	c3                   	ret    
80103235:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010323c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103240 <kinit1>:
{
80103240:	55                   	push   %ebp
80103241:	89 e5                	mov    %esp,%ebp
80103243:	56                   	push   %esi
80103244:	53                   	push   %ebx
80103245:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80103248:	83 ec 08             	sub    $0x8,%esp
8010324b:	68 cc 84 10 80       	push   $0x801084cc
80103250:	68 40 30 11 80       	push   $0x80113040
80103255:	e8 c6 20 00 00       	call   80105320 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010325a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010325d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80103260:	c7 05 74 30 11 80 00 	movl   $0x0,0x80113074
80103267:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010326a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80103270:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103276:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010327c:	39 de                	cmp    %ebx,%esi
8010327e:	72 1c                	jb     8010329c <kinit1+0x5c>
    kfree(p);
80103280:	83 ec 0c             	sub    $0xc,%esp
80103283:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103289:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010328f:	50                   	push   %eax
80103290:	e8 5b fe ff ff       	call   801030f0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103295:	83 c4 10             	add    $0x10,%esp
80103298:	39 de                	cmp    %ebx,%esi
8010329a:	73 e4                	jae    80103280 <kinit1+0x40>
}
8010329c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010329f:	5b                   	pop    %ebx
801032a0:	5e                   	pop    %esi
801032a1:	5d                   	pop    %ebp
801032a2:	c3                   	ret    
801032a3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801032aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801032b0 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
801032b0:	a1 74 30 11 80       	mov    0x80113074,%eax
801032b5:	85 c0                	test   %eax,%eax
801032b7:	75 1f                	jne    801032d8 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
801032b9:	a1 78 30 11 80       	mov    0x80113078,%eax
  if(r)
801032be:	85 c0                	test   %eax,%eax
801032c0:	74 0e                	je     801032d0 <kalloc+0x20>
    kmem.freelist = r->next;
801032c2:	8b 10                	mov    (%eax),%edx
801032c4:	89 15 78 30 11 80    	mov    %edx,0x80113078
  if(kmem.use_lock)
801032ca:	c3                   	ret    
801032cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801032cf:	90                   	nop
    release(&kmem.lock);
  return (char*)r;
}
801032d0:	c3                   	ret    
801032d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
801032d8:	55                   	push   %ebp
801032d9:	89 e5                	mov    %esp,%ebp
801032db:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
801032de:	68 40 30 11 80       	push   $0x80113040
801032e3:	e8 08 22 00 00       	call   801054f0 <acquire>
  r = kmem.freelist;
801032e8:	a1 78 30 11 80       	mov    0x80113078,%eax
  if(kmem.use_lock)
801032ed:	8b 15 74 30 11 80    	mov    0x80113074,%edx
  if(r)
801032f3:	83 c4 10             	add    $0x10,%esp
801032f6:	85 c0                	test   %eax,%eax
801032f8:	74 08                	je     80103302 <kalloc+0x52>
    kmem.freelist = r->next;
801032fa:	8b 08                	mov    (%eax),%ecx
801032fc:	89 0d 78 30 11 80    	mov    %ecx,0x80113078
  if(kmem.use_lock)
80103302:	85 d2                	test   %edx,%edx
80103304:	74 16                	je     8010331c <kalloc+0x6c>
    release(&kmem.lock);
80103306:	83 ec 0c             	sub    $0xc,%esp
80103309:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010330c:	68 40 30 11 80       	push   $0x80113040
80103311:	e8 7a 21 00 00       	call   80105490 <release>
  return (char*)r;
80103316:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80103319:	83 c4 10             	add    $0x10,%esp
}
8010331c:	c9                   	leave  
8010331d:	c3                   	ret    
8010331e:	66 90                	xchg   %ax,%ax

80103320 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103320:	ba 64 00 00 00       	mov    $0x64,%edx
80103325:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80103326:	a8 01                	test   $0x1,%al
80103328:	0f 84 c2 00 00 00    	je     801033f0 <kbdgetc+0xd0>
{
8010332e:	55                   	push   %ebp
8010332f:	ba 60 00 00 00       	mov    $0x60,%edx
80103334:	89 e5                	mov    %esp,%ebp
80103336:	53                   	push   %ebx
80103337:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
80103338:	8b 1d 7c 30 11 80    	mov    0x8011307c,%ebx
  data = inb(KBDATAP);
8010333e:	0f b6 c8             	movzbl %al,%ecx
  if(data == 0xE0){
80103341:	3c e0                	cmp    $0xe0,%al
80103343:	74 5b                	je     801033a0 <kbdgetc+0x80>
    return 0;
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80103345:	89 da                	mov    %ebx,%edx
80103347:	83 e2 40             	and    $0x40,%edx
  } else if(data & 0x80){
8010334a:	84 c0                	test   %al,%al
8010334c:	78 62                	js     801033b0 <kbdgetc+0x90>
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
8010334e:	85 d2                	test   %edx,%edx
80103350:	74 09                	je     8010335b <kbdgetc+0x3b>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80103352:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80103355:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
80103358:	0f b6 c8             	movzbl %al,%ecx
  }

  shift |= shiftcode[data];
8010335b:	0f b6 91 00 86 10 80 	movzbl -0x7fef7a00(%ecx),%edx
  shift ^= togglecode[data];
80103362:	0f b6 81 00 85 10 80 	movzbl -0x7fef7b00(%ecx),%eax
  shift |= shiftcode[data];
80103369:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
8010336b:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010336d:	89 d0                	mov    %edx,%eax
  shift ^= togglecode[data];
8010336f:	89 15 7c 30 11 80    	mov    %edx,0x8011307c
  c = charcode[shift & (CTL | SHIFT)][data];
80103375:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80103378:	83 e2 08             	and    $0x8,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010337b:	8b 04 85 e0 84 10 80 	mov    -0x7fef7b20(,%eax,4),%eax
80103382:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
80103386:	74 0b                	je     80103393 <kbdgetc+0x73>
    if('a' <= c && c <= 'z')
80103388:	8d 50 9f             	lea    -0x61(%eax),%edx
8010338b:	83 fa 19             	cmp    $0x19,%edx
8010338e:	77 48                	ja     801033d8 <kbdgetc+0xb8>
      c += 'A' - 'a';
80103390:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80103393:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103396:	c9                   	leave  
80103397:	c3                   	ret    
80103398:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010339f:	90                   	nop
    shift |= E0ESC;
801033a0:	83 cb 40             	or     $0x40,%ebx
    return 0;
801033a3:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
801033a5:	89 1d 7c 30 11 80    	mov    %ebx,0x8011307c
}
801033ab:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801033ae:	c9                   	leave  
801033af:	c3                   	ret    
    data = (shift & E0ESC ? data : data & 0x7F);
801033b0:	83 e0 7f             	and    $0x7f,%eax
801033b3:	85 d2                	test   %edx,%edx
801033b5:	0f 44 c8             	cmove  %eax,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
801033b8:	0f b6 81 00 86 10 80 	movzbl -0x7fef7a00(%ecx),%eax
801033bf:	83 c8 40             	or     $0x40,%eax
801033c2:	0f b6 c0             	movzbl %al,%eax
801033c5:	f7 d0                	not    %eax
801033c7:	21 d8                	and    %ebx,%eax
}
801033c9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    shift &= ~(shiftcode[data] | E0ESC);
801033cc:	a3 7c 30 11 80       	mov    %eax,0x8011307c
    return 0;
801033d1:	31 c0                	xor    %eax,%eax
}
801033d3:	c9                   	leave  
801033d4:	c3                   	ret    
801033d5:	8d 76 00             	lea    0x0(%esi),%esi
    else if('A' <= c && c <= 'Z')
801033d8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801033db:	8d 50 20             	lea    0x20(%eax),%edx
}
801033de:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801033e1:	c9                   	leave  
      c += 'a' - 'A';
801033e2:	83 f9 1a             	cmp    $0x1a,%ecx
801033e5:	0f 42 c2             	cmovb  %edx,%eax
}
801033e8:	c3                   	ret    
801033e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801033f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801033f5:	c3                   	ret    
801033f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801033fd:	8d 76 00             	lea    0x0(%esi),%esi

80103400 <kbdintr>:

void
kbdintr(void)
{
80103400:	55                   	push   %ebp
80103401:	89 e5                	mov    %esp,%ebp
80103403:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80103406:	68 20 33 10 80       	push   $0x80103320
8010340b:	e8 b0 d9 ff ff       	call   80100dc0 <consoleintr>
}
80103410:	83 c4 10             	add    $0x10,%esp
80103413:	c9                   	leave  
80103414:	c3                   	ret    
80103415:	66 90                	xchg   %ax,%ax
80103417:	66 90                	xchg   %ax,%ax
80103419:	66 90                	xchg   %ax,%ax
8010341b:	66 90                	xchg   %ax,%ax
8010341d:	66 90                	xchg   %ax,%ax
8010341f:	90                   	nop

80103420 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80103420:	a1 80 30 11 80       	mov    0x80113080,%eax
80103425:	85 c0                	test   %eax,%eax
80103427:	0f 84 cb 00 00 00    	je     801034f8 <lapicinit+0xd8>
  lapic[index] = value;
8010342d:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80103434:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103437:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010343a:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80103441:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103444:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103447:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
8010344e:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80103451:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103454:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010345b:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
8010345e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103461:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80103468:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010346b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010346e:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80103475:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80103478:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010347b:	8b 50 30             	mov    0x30(%eax),%edx
8010347e:	c1 ea 10             	shr    $0x10,%edx
80103481:	81 e2 fc 00 00 00    	and    $0xfc,%edx
80103487:	75 77                	jne    80103500 <lapicinit+0xe0>
  lapic[index] = value;
80103489:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80103490:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103493:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103496:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010349d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801034a0:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801034a3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801034aa:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801034ad:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801034b0:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801034b7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801034ba:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801034bd:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801034c4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801034c7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801034ca:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801034d1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
801034d4:	8b 50 20             	mov    0x20(%eax),%edx
801034d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801034de:	66 90                	xchg   %ax,%ax
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
801034e0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801034e6:	80 e6 10             	and    $0x10,%dh
801034e9:	75 f5                	jne    801034e0 <lapicinit+0xc0>
  lapic[index] = value;
801034eb:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801034f2:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801034f5:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
801034f8:	c3                   	ret    
801034f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
80103500:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80103507:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010350a:	8b 50 20             	mov    0x20(%eax),%edx
}
8010350d:	e9 77 ff ff ff       	jmp    80103489 <lapicinit+0x69>
80103512:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103520 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80103520:	a1 80 30 11 80       	mov    0x80113080,%eax
80103525:	85 c0                	test   %eax,%eax
80103527:	74 07                	je     80103530 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
80103529:	8b 40 20             	mov    0x20(%eax),%eax
8010352c:	c1 e8 18             	shr    $0x18,%eax
8010352f:	c3                   	ret    
    return 0;
80103530:	31 c0                	xor    %eax,%eax
}
80103532:	c3                   	ret    
80103533:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010353a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103540 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80103540:	a1 80 30 11 80       	mov    0x80113080,%eax
80103545:	85 c0                	test   %eax,%eax
80103547:	74 0d                	je     80103556 <lapiceoi+0x16>
  lapic[index] = value;
80103549:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80103550:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103553:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80103556:	c3                   	ret    
80103557:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010355e:	66 90                	xchg   %ax,%ax

80103560 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
80103560:	c3                   	ret    
80103561:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103568:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010356f:	90                   	nop

80103570 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80103570:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103571:	b8 0f 00 00 00       	mov    $0xf,%eax
80103576:	ba 70 00 00 00       	mov    $0x70,%edx
8010357b:	89 e5                	mov    %esp,%ebp
8010357d:	53                   	push   %ebx
8010357e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103581:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103584:	ee                   	out    %al,(%dx)
80103585:	b8 0a 00 00 00       	mov    $0xa,%eax
8010358a:	ba 71 00 00 00       	mov    $0x71,%edx
8010358f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80103590:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80103592:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80103595:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010359b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010359d:	c1 e9 0c             	shr    $0xc,%ecx
  lapicw(ICRHI, apicid<<24);
801035a0:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
801035a2:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
801035a5:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
801035a8:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
801035ae:	a1 80 30 11 80       	mov    0x80113080,%eax
801035b3:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801035b9:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801035bc:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801035c3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
801035c6:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801035c9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801035d0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801035d3:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801035d6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801035dc:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801035df:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801035e5:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801035e8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801035ee:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801035f1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801035f7:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
801035fa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801035fd:	c9                   	leave  
801035fe:	c3                   	ret    
801035ff:	90                   	nop

80103600 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80103600:	55                   	push   %ebp
80103601:	b8 0b 00 00 00       	mov    $0xb,%eax
80103606:	ba 70 00 00 00       	mov    $0x70,%edx
8010360b:	89 e5                	mov    %esp,%ebp
8010360d:	57                   	push   %edi
8010360e:	56                   	push   %esi
8010360f:	53                   	push   %ebx
80103610:	83 ec 4c             	sub    $0x4c,%esp
80103613:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103614:	ba 71 00 00 00       	mov    $0x71,%edx
80103619:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
8010361a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010361d:	bb 70 00 00 00       	mov    $0x70,%ebx
80103622:	88 45 b3             	mov    %al,-0x4d(%ebp)
80103625:	8d 76 00             	lea    0x0(%esi),%esi
80103628:	31 c0                	xor    %eax,%eax
8010362a:	89 da                	mov    %ebx,%edx
8010362c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010362d:	b9 71 00 00 00       	mov    $0x71,%ecx
80103632:	89 ca                	mov    %ecx,%edx
80103634:	ec                   	in     (%dx),%al
80103635:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103638:	89 da                	mov    %ebx,%edx
8010363a:	b8 02 00 00 00       	mov    $0x2,%eax
8010363f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103640:	89 ca                	mov    %ecx,%edx
80103642:	ec                   	in     (%dx),%al
80103643:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103646:	89 da                	mov    %ebx,%edx
80103648:	b8 04 00 00 00       	mov    $0x4,%eax
8010364d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010364e:	89 ca                	mov    %ecx,%edx
80103650:	ec                   	in     (%dx),%al
80103651:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103654:	89 da                	mov    %ebx,%edx
80103656:	b8 07 00 00 00       	mov    $0x7,%eax
8010365b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010365c:	89 ca                	mov    %ecx,%edx
8010365e:	ec                   	in     (%dx),%al
8010365f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103662:	89 da                	mov    %ebx,%edx
80103664:	b8 08 00 00 00       	mov    $0x8,%eax
80103669:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010366a:	89 ca                	mov    %ecx,%edx
8010366c:	ec                   	in     (%dx),%al
8010366d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010366f:	89 da                	mov    %ebx,%edx
80103671:	b8 09 00 00 00       	mov    $0x9,%eax
80103676:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103677:	89 ca                	mov    %ecx,%edx
80103679:	ec                   	in     (%dx),%al
8010367a:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010367c:	89 da                	mov    %ebx,%edx
8010367e:	b8 0a 00 00 00       	mov    $0xa,%eax
80103683:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103684:	89 ca                	mov    %ecx,%edx
80103686:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80103687:	84 c0                	test   %al,%al
80103689:	78 9d                	js     80103628 <cmostime+0x28>
  return inb(CMOS_RETURN);
8010368b:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
8010368f:	89 fa                	mov    %edi,%edx
80103691:	0f b6 fa             	movzbl %dl,%edi
80103694:	89 f2                	mov    %esi,%edx
80103696:	89 45 b8             	mov    %eax,-0x48(%ebp)
80103699:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
8010369d:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801036a0:	89 da                	mov    %ebx,%edx
801036a2:	89 7d c8             	mov    %edi,-0x38(%ebp)
801036a5:	89 45 bc             	mov    %eax,-0x44(%ebp)
801036a8:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
801036ac:	89 75 cc             	mov    %esi,-0x34(%ebp)
801036af:	89 45 c0             	mov    %eax,-0x40(%ebp)
801036b2:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
801036b6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
801036b9:	31 c0                	xor    %eax,%eax
801036bb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801036bc:	89 ca                	mov    %ecx,%edx
801036be:	ec                   	in     (%dx),%al
801036bf:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801036c2:	89 da                	mov    %ebx,%edx
801036c4:	89 45 d0             	mov    %eax,-0x30(%ebp)
801036c7:	b8 02 00 00 00       	mov    $0x2,%eax
801036cc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801036cd:	89 ca                	mov    %ecx,%edx
801036cf:	ec                   	in     (%dx),%al
801036d0:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801036d3:	89 da                	mov    %ebx,%edx
801036d5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801036d8:	b8 04 00 00 00       	mov    $0x4,%eax
801036dd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801036de:	89 ca                	mov    %ecx,%edx
801036e0:	ec                   	in     (%dx),%al
801036e1:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801036e4:	89 da                	mov    %ebx,%edx
801036e6:	89 45 d8             	mov    %eax,-0x28(%ebp)
801036e9:	b8 07 00 00 00       	mov    $0x7,%eax
801036ee:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801036ef:	89 ca                	mov    %ecx,%edx
801036f1:	ec                   	in     (%dx),%al
801036f2:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801036f5:	89 da                	mov    %ebx,%edx
801036f7:	89 45 dc             	mov    %eax,-0x24(%ebp)
801036fa:	b8 08 00 00 00       	mov    $0x8,%eax
801036ff:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103700:	89 ca                	mov    %ecx,%edx
80103702:	ec                   	in     (%dx),%al
80103703:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103706:	89 da                	mov    %ebx,%edx
80103708:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010370b:	b8 09 00 00 00       	mov    $0x9,%eax
80103710:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103711:	89 ca                	mov    %ecx,%edx
80103713:	ec                   	in     (%dx),%al
80103714:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80103717:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
8010371a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
8010371d:	8d 45 d0             	lea    -0x30(%ebp),%eax
80103720:	6a 18                	push   $0x18
80103722:	50                   	push   %eax
80103723:	8d 45 b8             	lea    -0x48(%ebp),%eax
80103726:	50                   	push   %eax
80103727:	e8 d4 1e 00 00       	call   80105600 <memcmp>
8010372c:	83 c4 10             	add    $0x10,%esp
8010372f:	85 c0                	test   %eax,%eax
80103731:	0f 85 f1 fe ff ff    	jne    80103628 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80103737:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
8010373b:	75 78                	jne    801037b5 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
8010373d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80103740:	89 c2                	mov    %eax,%edx
80103742:	83 e0 0f             	and    $0xf,%eax
80103745:	c1 ea 04             	shr    $0x4,%edx
80103748:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010374b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010374e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80103751:	8b 45 bc             	mov    -0x44(%ebp),%eax
80103754:	89 c2                	mov    %eax,%edx
80103756:	83 e0 0f             	and    $0xf,%eax
80103759:	c1 ea 04             	shr    $0x4,%edx
8010375c:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010375f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103762:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80103765:	8b 45 c0             	mov    -0x40(%ebp),%eax
80103768:	89 c2                	mov    %eax,%edx
8010376a:	83 e0 0f             	and    $0xf,%eax
8010376d:	c1 ea 04             	shr    $0x4,%edx
80103770:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103773:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103776:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80103779:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010377c:	89 c2                	mov    %eax,%edx
8010377e:	83 e0 0f             	and    $0xf,%eax
80103781:	c1 ea 04             	shr    $0x4,%edx
80103784:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103787:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010378a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
8010378d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80103790:	89 c2                	mov    %eax,%edx
80103792:	83 e0 0f             	and    $0xf,%eax
80103795:	c1 ea 04             	shr    $0x4,%edx
80103798:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010379b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010379e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
801037a1:	8b 45 cc             	mov    -0x34(%ebp),%eax
801037a4:	89 c2                	mov    %eax,%edx
801037a6:	83 e0 0f             	and    $0xf,%eax
801037a9:	c1 ea 04             	shr    $0x4,%edx
801037ac:	8d 14 92             	lea    (%edx,%edx,4),%edx
801037af:	8d 04 50             	lea    (%eax,%edx,2),%eax
801037b2:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
801037b5:	8b 75 08             	mov    0x8(%ebp),%esi
801037b8:	8b 45 b8             	mov    -0x48(%ebp),%eax
801037bb:	89 06                	mov    %eax,(%esi)
801037bd:	8b 45 bc             	mov    -0x44(%ebp),%eax
801037c0:	89 46 04             	mov    %eax,0x4(%esi)
801037c3:	8b 45 c0             	mov    -0x40(%ebp),%eax
801037c6:	89 46 08             	mov    %eax,0x8(%esi)
801037c9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801037cc:	89 46 0c             	mov    %eax,0xc(%esi)
801037cf:	8b 45 c8             	mov    -0x38(%ebp),%eax
801037d2:	89 46 10             	mov    %eax,0x10(%esi)
801037d5:	8b 45 cc             	mov    -0x34(%ebp),%eax
801037d8:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
801037db:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
801037e2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801037e5:	5b                   	pop    %ebx
801037e6:	5e                   	pop    %esi
801037e7:	5f                   	pop    %edi
801037e8:	5d                   	pop    %ebp
801037e9:	c3                   	ret    
801037ea:	66 90                	xchg   %ax,%ax
801037ec:	66 90                	xchg   %ax,%ax
801037ee:	66 90                	xchg   %ax,%ax

801037f0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801037f0:	8b 0d e8 30 11 80    	mov    0x801130e8,%ecx
801037f6:	85 c9                	test   %ecx,%ecx
801037f8:	0f 8e 8a 00 00 00    	jle    80103888 <install_trans+0x98>
{
801037fe:	55                   	push   %ebp
801037ff:	89 e5                	mov    %esp,%ebp
80103801:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
80103802:	31 ff                	xor    %edi,%edi
{
80103804:	56                   	push   %esi
80103805:	53                   	push   %ebx
80103806:	83 ec 0c             	sub    $0xc,%esp
80103809:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80103810:	a1 d4 30 11 80       	mov    0x801130d4,%eax
80103815:	83 ec 08             	sub    $0x8,%esp
80103818:	01 f8                	add    %edi,%eax
8010381a:	83 c0 01             	add    $0x1,%eax
8010381d:	50                   	push   %eax
8010381e:	ff 35 e4 30 11 80    	push   0x801130e4
80103824:	e8 a7 c8 ff ff       	call   801000d0 <bread>
80103829:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
8010382b:	58                   	pop    %eax
8010382c:	5a                   	pop    %edx
8010382d:	ff 34 bd ec 30 11 80 	push   -0x7feecf14(,%edi,4)
80103834:	ff 35 e4 30 11 80    	push   0x801130e4
  for (tail = 0; tail < log.lh.n; tail++) {
8010383a:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
8010383d:	e8 8e c8 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80103842:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80103845:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80103847:	8d 46 5c             	lea    0x5c(%esi),%eax
8010384a:	68 00 02 00 00       	push   $0x200
8010384f:	50                   	push   %eax
80103850:	8d 43 5c             	lea    0x5c(%ebx),%eax
80103853:	50                   	push   %eax
80103854:	e8 f7 1d 00 00       	call   80105650 <memmove>
    bwrite(dbuf);  // write dst to disk
80103859:	89 1c 24             	mov    %ebx,(%esp)
8010385c:	e8 4f c9 ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
80103861:	89 34 24             	mov    %esi,(%esp)
80103864:	e8 87 c9 ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
80103869:	89 1c 24             	mov    %ebx,(%esp)
8010386c:	e8 7f c9 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103871:	83 c4 10             	add    $0x10,%esp
80103874:	39 3d e8 30 11 80    	cmp    %edi,0x801130e8
8010387a:	7f 94                	jg     80103810 <install_trans+0x20>
  }
}
8010387c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010387f:	5b                   	pop    %ebx
80103880:	5e                   	pop    %esi
80103881:	5f                   	pop    %edi
80103882:	5d                   	pop    %ebp
80103883:	c3                   	ret    
80103884:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103888:	c3                   	ret    
80103889:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103890 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80103890:	55                   	push   %ebp
80103891:	89 e5                	mov    %esp,%ebp
80103893:	53                   	push   %ebx
80103894:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80103897:	ff 35 d4 30 11 80    	push   0x801130d4
8010389d:	ff 35 e4 30 11 80    	push   0x801130e4
801038a3:	e8 28 c8 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
801038a8:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
801038ab:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
801038ad:	a1 e8 30 11 80       	mov    0x801130e8,%eax
801038b2:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
801038b5:	85 c0                	test   %eax,%eax
801038b7:	7e 19                	jle    801038d2 <write_head+0x42>
801038b9:	31 d2                	xor    %edx,%edx
801038bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801038bf:	90                   	nop
    hb->block[i] = log.lh.block[i];
801038c0:	8b 0c 95 ec 30 11 80 	mov    -0x7feecf14(,%edx,4),%ecx
801038c7:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
801038cb:	83 c2 01             	add    $0x1,%edx
801038ce:	39 d0                	cmp    %edx,%eax
801038d0:	75 ee                	jne    801038c0 <write_head+0x30>
  }
  bwrite(buf);
801038d2:	83 ec 0c             	sub    $0xc,%esp
801038d5:	53                   	push   %ebx
801038d6:	e8 d5 c8 ff ff       	call   801001b0 <bwrite>
  brelse(buf);
801038db:	89 1c 24             	mov    %ebx,(%esp)
801038de:	e8 0d c9 ff ff       	call   801001f0 <brelse>
}
801038e3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801038e6:	83 c4 10             	add    $0x10,%esp
801038e9:	c9                   	leave  
801038ea:	c3                   	ret    
801038eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801038ef:	90                   	nop

801038f0 <initlog>:
{
801038f0:	55                   	push   %ebp
801038f1:	89 e5                	mov    %esp,%ebp
801038f3:	53                   	push   %ebx
801038f4:	83 ec 2c             	sub    $0x2c,%esp
801038f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
801038fa:	68 00 87 10 80       	push   $0x80108700
801038ff:	68 a0 30 11 80       	push   $0x801130a0
80103904:	e8 17 1a 00 00       	call   80105320 <initlock>
  readsb(dev, &sb);
80103909:	58                   	pop    %eax
8010390a:	8d 45 dc             	lea    -0x24(%ebp),%eax
8010390d:	5a                   	pop    %edx
8010390e:	50                   	push   %eax
8010390f:	53                   	push   %ebx
80103910:	e8 3b e8 ff ff       	call   80102150 <readsb>
  log.start = sb.logstart;
80103915:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80103918:	59                   	pop    %ecx
  log.dev = dev;
80103919:	89 1d e4 30 11 80    	mov    %ebx,0x801130e4
  log.size = sb.nlog;
8010391f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80103922:	a3 d4 30 11 80       	mov    %eax,0x801130d4
  log.size = sb.nlog;
80103927:	89 15 d8 30 11 80    	mov    %edx,0x801130d8
  struct buf *buf = bread(log.dev, log.start);
8010392d:	5a                   	pop    %edx
8010392e:	50                   	push   %eax
8010392f:	53                   	push   %ebx
80103930:	e8 9b c7 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80103935:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
80103938:	8b 58 5c             	mov    0x5c(%eax),%ebx
8010393b:	89 1d e8 30 11 80    	mov    %ebx,0x801130e8
  for (i = 0; i < log.lh.n; i++) {
80103941:	85 db                	test   %ebx,%ebx
80103943:	7e 1d                	jle    80103962 <initlog+0x72>
80103945:	31 d2                	xor    %edx,%edx
80103947:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010394e:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80103950:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
80103954:	89 0c 95 ec 30 11 80 	mov    %ecx,-0x7feecf14(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
8010395b:	83 c2 01             	add    $0x1,%edx
8010395e:	39 d3                	cmp    %edx,%ebx
80103960:	75 ee                	jne    80103950 <initlog+0x60>
  brelse(buf);
80103962:	83 ec 0c             	sub    $0xc,%esp
80103965:	50                   	push   %eax
80103966:	e8 85 c8 ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
8010396b:	e8 80 fe ff ff       	call   801037f0 <install_trans>
  log.lh.n = 0;
80103970:	c7 05 e8 30 11 80 00 	movl   $0x0,0x801130e8
80103977:	00 00 00 
  write_head(); // clear the log
8010397a:	e8 11 ff ff ff       	call   80103890 <write_head>
}
8010397f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103982:	83 c4 10             	add    $0x10,%esp
80103985:	c9                   	leave  
80103986:	c3                   	ret    
80103987:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010398e:	66 90                	xchg   %ax,%ax

80103990 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80103990:	55                   	push   %ebp
80103991:	89 e5                	mov    %esp,%ebp
80103993:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80103996:	68 a0 30 11 80       	push   $0x801130a0
8010399b:	e8 50 1b 00 00       	call   801054f0 <acquire>
801039a0:	83 c4 10             	add    $0x10,%esp
801039a3:	eb 18                	jmp    801039bd <begin_op+0x2d>
801039a5:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
801039a8:	83 ec 08             	sub    $0x8,%esp
801039ab:	68 a0 30 11 80       	push   $0x801130a0
801039b0:	68 a0 30 11 80       	push   $0x801130a0
801039b5:	e8 96 14 00 00       	call   80104e50 <sleep>
801039ba:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
801039bd:	a1 e0 30 11 80       	mov    0x801130e0,%eax
801039c2:	85 c0                	test   %eax,%eax
801039c4:	75 e2                	jne    801039a8 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
801039c6:	a1 dc 30 11 80       	mov    0x801130dc,%eax
801039cb:	8b 15 e8 30 11 80    	mov    0x801130e8,%edx
801039d1:	83 c0 01             	add    $0x1,%eax
801039d4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
801039d7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
801039da:	83 fa 1e             	cmp    $0x1e,%edx
801039dd:	7f c9                	jg     801039a8 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
801039df:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
801039e2:	a3 dc 30 11 80       	mov    %eax,0x801130dc
      release(&log.lock);
801039e7:	68 a0 30 11 80       	push   $0x801130a0
801039ec:	e8 9f 1a 00 00       	call   80105490 <release>
      break;
    }
  }
}
801039f1:	83 c4 10             	add    $0x10,%esp
801039f4:	c9                   	leave  
801039f5:	c3                   	ret    
801039f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801039fd:	8d 76 00             	lea    0x0(%esi),%esi

80103a00 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80103a00:	55                   	push   %ebp
80103a01:	89 e5                	mov    %esp,%ebp
80103a03:	57                   	push   %edi
80103a04:	56                   	push   %esi
80103a05:	53                   	push   %ebx
80103a06:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80103a09:	68 a0 30 11 80       	push   $0x801130a0
80103a0e:	e8 dd 1a 00 00       	call   801054f0 <acquire>
  log.outstanding -= 1;
80103a13:	a1 dc 30 11 80       	mov    0x801130dc,%eax
  if(log.committing)
80103a18:	8b 35 e0 30 11 80    	mov    0x801130e0,%esi
80103a1e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80103a21:	8d 58 ff             	lea    -0x1(%eax),%ebx
80103a24:	89 1d dc 30 11 80    	mov    %ebx,0x801130dc
  if(log.committing)
80103a2a:	85 f6                	test   %esi,%esi
80103a2c:	0f 85 22 01 00 00    	jne    80103b54 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80103a32:	85 db                	test   %ebx,%ebx
80103a34:	0f 85 f6 00 00 00    	jne    80103b30 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
80103a3a:	c7 05 e0 30 11 80 01 	movl   $0x1,0x801130e0
80103a41:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80103a44:	83 ec 0c             	sub    $0xc,%esp
80103a47:	68 a0 30 11 80       	push   $0x801130a0
80103a4c:	e8 3f 1a 00 00       	call   80105490 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80103a51:	8b 0d e8 30 11 80    	mov    0x801130e8,%ecx
80103a57:	83 c4 10             	add    $0x10,%esp
80103a5a:	85 c9                	test   %ecx,%ecx
80103a5c:	7f 42                	jg     80103aa0 <end_op+0xa0>
    acquire(&log.lock);
80103a5e:	83 ec 0c             	sub    $0xc,%esp
80103a61:	68 a0 30 11 80       	push   $0x801130a0
80103a66:	e8 85 1a 00 00       	call   801054f0 <acquire>
    wakeup(&log);
80103a6b:	c7 04 24 a0 30 11 80 	movl   $0x801130a0,(%esp)
    log.committing = 0;
80103a72:	c7 05 e0 30 11 80 00 	movl   $0x0,0x801130e0
80103a79:	00 00 00 
    wakeup(&log);
80103a7c:	e8 8f 14 00 00       	call   80104f10 <wakeup>
    release(&log.lock);
80103a81:	c7 04 24 a0 30 11 80 	movl   $0x801130a0,(%esp)
80103a88:	e8 03 1a 00 00       	call   80105490 <release>
80103a8d:	83 c4 10             	add    $0x10,%esp
}
80103a90:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103a93:	5b                   	pop    %ebx
80103a94:	5e                   	pop    %esi
80103a95:	5f                   	pop    %edi
80103a96:	5d                   	pop    %ebp
80103a97:	c3                   	ret    
80103a98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103a9f:	90                   	nop
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103aa0:	a1 d4 30 11 80       	mov    0x801130d4,%eax
80103aa5:	83 ec 08             	sub    $0x8,%esp
80103aa8:	01 d8                	add    %ebx,%eax
80103aaa:	83 c0 01             	add    $0x1,%eax
80103aad:	50                   	push   %eax
80103aae:	ff 35 e4 30 11 80    	push   0x801130e4
80103ab4:	e8 17 c6 ff ff       	call   801000d0 <bread>
80103ab9:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103abb:	58                   	pop    %eax
80103abc:	5a                   	pop    %edx
80103abd:	ff 34 9d ec 30 11 80 	push   -0x7feecf14(,%ebx,4)
80103ac4:	ff 35 e4 30 11 80    	push   0x801130e4
  for (tail = 0; tail < log.lh.n; tail++) {
80103aca:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103acd:	e8 fe c5 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80103ad2:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103ad5:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80103ad7:	8d 40 5c             	lea    0x5c(%eax),%eax
80103ada:	68 00 02 00 00       	push   $0x200
80103adf:	50                   	push   %eax
80103ae0:	8d 46 5c             	lea    0x5c(%esi),%eax
80103ae3:	50                   	push   %eax
80103ae4:	e8 67 1b 00 00       	call   80105650 <memmove>
    bwrite(to);  // write the log
80103ae9:	89 34 24             	mov    %esi,(%esp)
80103aec:	e8 bf c6 ff ff       	call   801001b0 <bwrite>
    brelse(from);
80103af1:	89 3c 24             	mov    %edi,(%esp)
80103af4:	e8 f7 c6 ff ff       	call   801001f0 <brelse>
    brelse(to);
80103af9:	89 34 24             	mov    %esi,(%esp)
80103afc:	e8 ef c6 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103b01:	83 c4 10             	add    $0x10,%esp
80103b04:	3b 1d e8 30 11 80    	cmp    0x801130e8,%ebx
80103b0a:	7c 94                	jl     80103aa0 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80103b0c:	e8 7f fd ff ff       	call   80103890 <write_head>
    install_trans(); // Now install writes to home locations
80103b11:	e8 da fc ff ff       	call   801037f0 <install_trans>
    log.lh.n = 0;
80103b16:	c7 05 e8 30 11 80 00 	movl   $0x0,0x801130e8
80103b1d:	00 00 00 
    write_head();    // Erase the transaction from the log
80103b20:	e8 6b fd ff ff       	call   80103890 <write_head>
80103b25:	e9 34 ff ff ff       	jmp    80103a5e <end_op+0x5e>
80103b2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
80103b30:	83 ec 0c             	sub    $0xc,%esp
80103b33:	68 a0 30 11 80       	push   $0x801130a0
80103b38:	e8 d3 13 00 00       	call   80104f10 <wakeup>
  release(&log.lock);
80103b3d:	c7 04 24 a0 30 11 80 	movl   $0x801130a0,(%esp)
80103b44:	e8 47 19 00 00       	call   80105490 <release>
80103b49:	83 c4 10             	add    $0x10,%esp
}
80103b4c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b4f:	5b                   	pop    %ebx
80103b50:	5e                   	pop    %esi
80103b51:	5f                   	pop    %edi
80103b52:	5d                   	pop    %ebp
80103b53:	c3                   	ret    
    panic("log.committing");
80103b54:	83 ec 0c             	sub    $0xc,%esp
80103b57:	68 04 87 10 80       	push   $0x80108704
80103b5c:	e8 1f c8 ff ff       	call   80100380 <panic>
80103b61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103b68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103b6f:	90                   	nop

80103b70 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103b70:	55                   	push   %ebp
80103b71:	89 e5                	mov    %esp,%ebp
80103b73:	53                   	push   %ebx
80103b74:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103b77:	8b 15 e8 30 11 80    	mov    0x801130e8,%edx
{
80103b7d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103b80:	83 fa 1d             	cmp    $0x1d,%edx
80103b83:	0f 8f 85 00 00 00    	jg     80103c0e <log_write+0x9e>
80103b89:	a1 d8 30 11 80       	mov    0x801130d8,%eax
80103b8e:	83 e8 01             	sub    $0x1,%eax
80103b91:	39 c2                	cmp    %eax,%edx
80103b93:	7d 79                	jge    80103c0e <log_write+0x9e>
    panic("too big a transaction");
  if (log.outstanding < 1)
80103b95:	a1 dc 30 11 80       	mov    0x801130dc,%eax
80103b9a:	85 c0                	test   %eax,%eax
80103b9c:	7e 7d                	jle    80103c1b <log_write+0xab>
    panic("log_write outside of trans");

  acquire(&log.lock);
80103b9e:	83 ec 0c             	sub    $0xc,%esp
80103ba1:	68 a0 30 11 80       	push   $0x801130a0
80103ba6:	e8 45 19 00 00       	call   801054f0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80103bab:	8b 15 e8 30 11 80    	mov    0x801130e8,%edx
80103bb1:	83 c4 10             	add    $0x10,%esp
80103bb4:	85 d2                	test   %edx,%edx
80103bb6:	7e 4a                	jle    80103c02 <log_write+0x92>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103bb8:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
80103bbb:	31 c0                	xor    %eax,%eax
80103bbd:	eb 08                	jmp    80103bc7 <log_write+0x57>
80103bbf:	90                   	nop
80103bc0:	83 c0 01             	add    $0x1,%eax
80103bc3:	39 c2                	cmp    %eax,%edx
80103bc5:	74 29                	je     80103bf0 <log_write+0x80>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103bc7:	39 0c 85 ec 30 11 80 	cmp    %ecx,-0x7feecf14(,%eax,4)
80103bce:	75 f0                	jne    80103bc0 <log_write+0x50>
      break;
  }
  log.lh.block[i] = b->blockno;
80103bd0:	89 0c 85 ec 30 11 80 	mov    %ecx,-0x7feecf14(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
80103bd7:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
80103bda:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
80103bdd:	c7 45 08 a0 30 11 80 	movl   $0x801130a0,0x8(%ebp)
}
80103be4:	c9                   	leave  
  release(&log.lock);
80103be5:	e9 a6 18 00 00       	jmp    80105490 <release>
80103bea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80103bf0:	89 0c 95 ec 30 11 80 	mov    %ecx,-0x7feecf14(,%edx,4)
    log.lh.n++;
80103bf7:	83 c2 01             	add    $0x1,%edx
80103bfa:	89 15 e8 30 11 80    	mov    %edx,0x801130e8
80103c00:	eb d5                	jmp    80103bd7 <log_write+0x67>
  log.lh.block[i] = b->blockno;
80103c02:	8b 43 08             	mov    0x8(%ebx),%eax
80103c05:	a3 ec 30 11 80       	mov    %eax,0x801130ec
  if (i == log.lh.n)
80103c0a:	75 cb                	jne    80103bd7 <log_write+0x67>
80103c0c:	eb e9                	jmp    80103bf7 <log_write+0x87>
    panic("too big a transaction");
80103c0e:	83 ec 0c             	sub    $0xc,%esp
80103c11:	68 13 87 10 80       	push   $0x80108713
80103c16:	e8 65 c7 ff ff       	call   80100380 <panic>
    panic("log_write outside of trans");
80103c1b:	83 ec 0c             	sub    $0xc,%esp
80103c1e:	68 29 87 10 80       	push   $0x80108729
80103c23:	e8 58 c7 ff ff       	call   80100380 <panic>
80103c28:	66 90                	xchg   %ax,%ax
80103c2a:	66 90                	xchg   %ax,%ax
80103c2c:	66 90                	xchg   %ax,%ax
80103c2e:	66 90                	xchg   %ax,%ax

80103c30 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103c30:	55                   	push   %ebp
80103c31:	89 e5                	mov    %esp,%ebp
80103c33:	53                   	push   %ebx
80103c34:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103c37:	e8 84 09 00 00       	call   801045c0 <cpuid>
80103c3c:	89 c3                	mov    %eax,%ebx
80103c3e:	e8 7d 09 00 00       	call   801045c0 <cpuid>
80103c43:	83 ec 04             	sub    $0x4,%esp
80103c46:	53                   	push   %ebx
80103c47:	50                   	push   %eax
80103c48:	68 44 87 10 80       	push   $0x80108744
80103c4d:	e8 3e cb ff ff       	call   80100790 <cprintf>
  idtinit();       // load idt register
80103c52:	e8 49 2d 00 00       	call   801069a0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103c57:	e8 04 09 00 00       	call   80104560 <mycpu>
80103c5c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80103c5e:	b8 01 00 00 00       	mov    $0x1,%eax
80103c63:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80103c6a:	e8 51 0c 00 00       	call   801048c0 <scheduler>
80103c6f:	90                   	nop

80103c70 <mpenter>:
{
80103c70:	55                   	push   %ebp
80103c71:	89 e5                	mov    %esp,%ebp
80103c73:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103c76:	e8 25 3e 00 00       	call   80107aa0 <switchkvm>
  seginit();
80103c7b:	e8 90 3d 00 00       	call   80107a10 <seginit>
  lapicinit();
80103c80:	e8 9b f7 ff ff       	call   80103420 <lapicinit>
  mpmain();
80103c85:	e8 a6 ff ff ff       	call   80103c30 <mpmain>
80103c8a:	66 90                	xchg   %ax,%ax
80103c8c:	66 90                	xchg   %ax,%ax
80103c8e:	66 90                	xchg   %ax,%ax

80103c90 <main>:
{
80103c90:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103c94:	83 e4 f0             	and    $0xfffffff0,%esp
80103c97:	ff 71 fc             	push   -0x4(%ecx)
80103c9a:	55                   	push   %ebp
80103c9b:	89 e5                	mov    %esp,%ebp
80103c9d:	53                   	push   %ebx
80103c9e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80103c9f:	83 ec 08             	sub    $0x8,%esp
80103ca2:	68 00 00 40 80       	push   $0x80400000
80103ca7:	68 d0 75 11 80       	push   $0x801175d0
80103cac:	e8 8f f5 ff ff       	call   80103240 <kinit1>
  kvmalloc();      // kernel page table
80103cb1:	e8 da 42 00 00       	call   80107f90 <kvmalloc>
  mpinit();        // detect other processors
80103cb6:	e8 85 01 00 00       	call   80103e40 <mpinit>
  lapicinit();     // interrupt controller
80103cbb:	e8 60 f7 ff ff       	call   80103420 <lapicinit>
  seginit();       // segment descriptors
80103cc0:	e8 4b 3d 00 00       	call   80107a10 <seginit>
  picinit();       // disable pic
80103cc5:	e8 76 03 00 00       	call   80104040 <picinit>
  ioapicinit();    // another interrupt controller
80103cca:	e8 31 f3 ff ff       	call   80103000 <ioapicinit>
  consoleinit();   // console hardware
80103ccf:	e8 ac d9 ff ff       	call   80101680 <consoleinit>
  uartinit();      // serial port
80103cd4:	e8 c7 2f 00 00       	call   80106ca0 <uartinit>
  pinit();         // process table
80103cd9:	e8 62 08 00 00       	call   80104540 <pinit>
  tvinit();        // trap vectors
80103cde:	e8 3d 2c 00 00       	call   80106920 <tvinit>
  binit();         // buffer cache
80103ce3:	e8 58 c3 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80103ce8:	e8 53 dd ff ff       	call   80101a40 <fileinit>
  ideinit();       // disk 
80103ced:	e8 fe f0 ff ff       	call   80102df0 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103cf2:	83 c4 0c             	add    $0xc,%esp
80103cf5:	68 8a 00 00 00       	push   $0x8a
80103cfa:	68 8c b4 10 80       	push   $0x8010b48c
80103cff:	68 00 70 00 80       	push   $0x80007000
80103d04:	e8 47 19 00 00       	call   80105650 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103d09:	83 c4 10             	add    $0x10,%esp
80103d0c:	69 05 84 31 11 80 b0 	imul   $0xb0,0x80113184,%eax
80103d13:	00 00 00 
80103d16:	05 a0 31 11 80       	add    $0x801131a0,%eax
80103d1b:	3d a0 31 11 80       	cmp    $0x801131a0,%eax
80103d20:	76 7e                	jbe    80103da0 <main+0x110>
80103d22:	bb a0 31 11 80       	mov    $0x801131a0,%ebx
80103d27:	eb 20                	jmp    80103d49 <main+0xb9>
80103d29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103d30:	69 05 84 31 11 80 b0 	imul   $0xb0,0x80113184,%eax
80103d37:	00 00 00 
80103d3a:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80103d40:	05 a0 31 11 80       	add    $0x801131a0,%eax
80103d45:	39 c3                	cmp    %eax,%ebx
80103d47:	73 57                	jae    80103da0 <main+0x110>
    if(c == mycpu())  // We've started already.
80103d49:	e8 12 08 00 00       	call   80104560 <mycpu>
80103d4e:	39 c3                	cmp    %eax,%ebx
80103d50:	74 de                	je     80103d30 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103d52:	e8 59 f5 ff ff       	call   801032b0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103d57:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
80103d5a:	c7 05 f8 6f 00 80 70 	movl   $0x80103c70,0x80006ff8
80103d61:	3c 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103d64:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
80103d6b:	a0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
80103d6e:	05 00 10 00 00       	add    $0x1000,%eax
80103d73:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
80103d78:	0f b6 03             	movzbl (%ebx),%eax
80103d7b:	68 00 70 00 00       	push   $0x7000
80103d80:	50                   	push   %eax
80103d81:	e8 ea f7 ff ff       	call   80103570 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103d86:	83 c4 10             	add    $0x10,%esp
80103d89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103d90:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103d96:	85 c0                	test   %eax,%eax
80103d98:	74 f6                	je     80103d90 <main+0x100>
80103d9a:	eb 94                	jmp    80103d30 <main+0xa0>
80103d9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103da0:	83 ec 08             	sub    $0x8,%esp
80103da3:	68 00 00 00 8e       	push   $0x8e000000
80103da8:	68 00 00 40 80       	push   $0x80400000
80103dad:	e8 2e f4 ff ff       	call   801031e0 <kinit2>
  userinit();      // first user process
80103db2:	e8 59 08 00 00       	call   80104610 <userinit>
  mpmain();        // finish this processor's setup
80103db7:	e8 74 fe ff ff       	call   80103c30 <mpmain>
80103dbc:	66 90                	xchg   %ax,%ax
80103dbe:	66 90                	xchg   %ax,%ax

80103dc0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103dc0:	55                   	push   %ebp
80103dc1:	89 e5                	mov    %esp,%ebp
80103dc3:	57                   	push   %edi
80103dc4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103dc5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
80103dcb:	53                   	push   %ebx
  e = addr+len;
80103dcc:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
80103dcf:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103dd2:	39 de                	cmp    %ebx,%esi
80103dd4:	72 10                	jb     80103de6 <mpsearch1+0x26>
80103dd6:	eb 50                	jmp    80103e28 <mpsearch1+0x68>
80103dd8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103ddf:	90                   	nop
80103de0:	89 fe                	mov    %edi,%esi
80103de2:	39 fb                	cmp    %edi,%ebx
80103de4:	76 42                	jbe    80103e28 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103de6:	83 ec 04             	sub    $0x4,%esp
80103de9:	8d 7e 10             	lea    0x10(%esi),%edi
80103dec:	6a 04                	push   $0x4
80103dee:	68 58 87 10 80       	push   $0x80108758
80103df3:	56                   	push   %esi
80103df4:	e8 07 18 00 00       	call   80105600 <memcmp>
80103df9:	83 c4 10             	add    $0x10,%esp
80103dfc:	85 c0                	test   %eax,%eax
80103dfe:	75 e0                	jne    80103de0 <mpsearch1+0x20>
80103e00:	89 f2                	mov    %esi,%edx
80103e02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103e08:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
80103e0b:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
80103e0e:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103e10:	39 fa                	cmp    %edi,%edx
80103e12:	75 f4                	jne    80103e08 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103e14:	84 c0                	test   %al,%al
80103e16:	75 c8                	jne    80103de0 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103e18:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103e1b:	89 f0                	mov    %esi,%eax
80103e1d:	5b                   	pop    %ebx
80103e1e:	5e                   	pop    %esi
80103e1f:	5f                   	pop    %edi
80103e20:	5d                   	pop    %ebp
80103e21:	c3                   	ret    
80103e22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103e28:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80103e2b:	31 f6                	xor    %esi,%esi
}
80103e2d:	5b                   	pop    %ebx
80103e2e:	89 f0                	mov    %esi,%eax
80103e30:	5e                   	pop    %esi
80103e31:	5f                   	pop    %edi
80103e32:	5d                   	pop    %ebp
80103e33:	c3                   	ret    
80103e34:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103e3f:	90                   	nop

80103e40 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103e40:	55                   	push   %ebp
80103e41:	89 e5                	mov    %esp,%ebp
80103e43:	57                   	push   %edi
80103e44:	56                   	push   %esi
80103e45:	53                   	push   %ebx
80103e46:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103e49:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103e50:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103e57:	c1 e0 08             	shl    $0x8,%eax
80103e5a:	09 d0                	or     %edx,%eax
80103e5c:	c1 e0 04             	shl    $0x4,%eax
80103e5f:	75 1b                	jne    80103e7c <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103e61:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80103e68:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103e6f:	c1 e0 08             	shl    $0x8,%eax
80103e72:	09 d0                	or     %edx,%eax
80103e74:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103e77:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
80103e7c:	ba 00 04 00 00       	mov    $0x400,%edx
80103e81:	e8 3a ff ff ff       	call   80103dc0 <mpsearch1>
80103e86:	89 c3                	mov    %eax,%ebx
80103e88:	85 c0                	test   %eax,%eax
80103e8a:	0f 84 40 01 00 00    	je     80103fd0 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103e90:	8b 73 04             	mov    0x4(%ebx),%esi
80103e93:	85 f6                	test   %esi,%esi
80103e95:	0f 84 25 01 00 00    	je     80103fc0 <mpinit+0x180>
  if(memcmp(conf, "PCMP", 4) != 0)
80103e9b:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103e9e:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
80103ea4:	6a 04                	push   $0x4
80103ea6:	68 5d 87 10 80       	push   $0x8010875d
80103eab:	50                   	push   %eax
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103eac:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103eaf:	e8 4c 17 00 00       	call   80105600 <memcmp>
80103eb4:	83 c4 10             	add    $0x10,%esp
80103eb7:	85 c0                	test   %eax,%eax
80103eb9:	0f 85 01 01 00 00    	jne    80103fc0 <mpinit+0x180>
  if(conf->version != 1 && conf->version != 4)
80103ebf:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
80103ec6:	3c 01                	cmp    $0x1,%al
80103ec8:	74 08                	je     80103ed2 <mpinit+0x92>
80103eca:	3c 04                	cmp    $0x4,%al
80103ecc:	0f 85 ee 00 00 00    	jne    80103fc0 <mpinit+0x180>
  if(sum((uchar*)conf, conf->length) != 0)
80103ed2:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
  for(i=0; i<len; i++)
80103ed9:	66 85 d2             	test   %dx,%dx
80103edc:	74 22                	je     80103f00 <mpinit+0xc0>
80103ede:	8d 3c 32             	lea    (%edx,%esi,1),%edi
80103ee1:	89 f0                	mov    %esi,%eax
  sum = 0;
80103ee3:	31 d2                	xor    %edx,%edx
80103ee5:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80103ee8:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
  for(i=0; i<len; i++)
80103eef:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
80103ef2:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80103ef4:	39 c7                	cmp    %eax,%edi
80103ef6:	75 f0                	jne    80103ee8 <mpinit+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
80103ef8:	84 d2                	test   %dl,%dl
80103efa:	0f 85 c0 00 00 00    	jne    80103fc0 <mpinit+0x180>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103f00:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
80103f06:	a3 80 30 11 80       	mov    %eax,0x80113080
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103f0b:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
80103f12:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
  ismp = 1;
80103f18:	be 01 00 00 00       	mov    $0x1,%esi
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103f1d:	03 55 e4             	add    -0x1c(%ebp),%edx
80103f20:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80103f23:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f27:	90                   	nop
80103f28:	39 d0                	cmp    %edx,%eax
80103f2a:	73 15                	jae    80103f41 <mpinit+0x101>
    switch(*p){
80103f2c:	0f b6 08             	movzbl (%eax),%ecx
80103f2f:	80 f9 02             	cmp    $0x2,%cl
80103f32:	74 4c                	je     80103f80 <mpinit+0x140>
80103f34:	77 3a                	ja     80103f70 <mpinit+0x130>
80103f36:	84 c9                	test   %cl,%cl
80103f38:	74 56                	je     80103f90 <mpinit+0x150>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103f3a:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103f3d:	39 d0                	cmp    %edx,%eax
80103f3f:	72 eb                	jb     80103f2c <mpinit+0xec>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103f41:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103f44:	85 f6                	test   %esi,%esi
80103f46:	0f 84 d9 00 00 00    	je     80104025 <mpinit+0x1e5>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
80103f4c:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
80103f50:	74 15                	je     80103f67 <mpinit+0x127>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103f52:	b8 70 00 00 00       	mov    $0x70,%eax
80103f57:	ba 22 00 00 00       	mov    $0x22,%edx
80103f5c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103f5d:	ba 23 00 00 00       	mov    $0x23,%edx
80103f62:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103f63:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103f66:	ee                   	out    %al,(%dx)
  }
}
80103f67:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f6a:	5b                   	pop    %ebx
80103f6b:	5e                   	pop    %esi
80103f6c:	5f                   	pop    %edi
80103f6d:	5d                   	pop    %ebp
80103f6e:	c3                   	ret    
80103f6f:	90                   	nop
    switch(*p){
80103f70:	83 e9 03             	sub    $0x3,%ecx
80103f73:	80 f9 01             	cmp    $0x1,%cl
80103f76:	76 c2                	jbe    80103f3a <mpinit+0xfa>
80103f78:	31 f6                	xor    %esi,%esi
80103f7a:	eb ac                	jmp    80103f28 <mpinit+0xe8>
80103f7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
80103f80:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
80103f84:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
80103f87:	88 0d 80 31 11 80    	mov    %cl,0x80113180
      continue;
80103f8d:	eb 99                	jmp    80103f28 <mpinit+0xe8>
80103f8f:	90                   	nop
      if(ncpu < NCPU) {
80103f90:	8b 0d 84 31 11 80    	mov    0x80113184,%ecx
80103f96:	83 f9 07             	cmp    $0x7,%ecx
80103f99:	7f 19                	jg     80103fb4 <mpinit+0x174>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103f9b:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
80103fa1:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
80103fa5:	83 c1 01             	add    $0x1,%ecx
80103fa8:	89 0d 84 31 11 80    	mov    %ecx,0x80113184
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103fae:	88 9f a0 31 11 80    	mov    %bl,-0x7feece60(%edi)
      p += sizeof(struct mpproc);
80103fb4:	83 c0 14             	add    $0x14,%eax
      continue;
80103fb7:	e9 6c ff ff ff       	jmp    80103f28 <mpinit+0xe8>
80103fbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    panic("Expect to run on an SMP");
80103fc0:	83 ec 0c             	sub    $0xc,%esp
80103fc3:	68 62 87 10 80       	push   $0x80108762
80103fc8:	e8 b3 c3 ff ff       	call   80100380 <panic>
80103fcd:	8d 76 00             	lea    0x0(%esi),%esi
{
80103fd0:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
80103fd5:	eb 13                	jmp    80103fea <mpinit+0x1aa>
80103fd7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103fde:	66 90                	xchg   %ax,%ax
  for(p = addr; p < e; p += sizeof(struct mp))
80103fe0:	89 f3                	mov    %esi,%ebx
80103fe2:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
80103fe8:	74 d6                	je     80103fc0 <mpinit+0x180>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103fea:	83 ec 04             	sub    $0x4,%esp
80103fed:	8d 73 10             	lea    0x10(%ebx),%esi
80103ff0:	6a 04                	push   $0x4
80103ff2:	68 58 87 10 80       	push   $0x80108758
80103ff7:	53                   	push   %ebx
80103ff8:	e8 03 16 00 00       	call   80105600 <memcmp>
80103ffd:	83 c4 10             	add    $0x10,%esp
80104000:	85 c0                	test   %eax,%eax
80104002:	75 dc                	jne    80103fe0 <mpinit+0x1a0>
80104004:	89 da                	mov    %ebx,%edx
80104006:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010400d:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80104010:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
80104013:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
80104016:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80104018:	39 d6                	cmp    %edx,%esi
8010401a:	75 f4                	jne    80104010 <mpinit+0x1d0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010401c:	84 c0                	test   %al,%al
8010401e:	75 c0                	jne    80103fe0 <mpinit+0x1a0>
80104020:	e9 6b fe ff ff       	jmp    80103e90 <mpinit+0x50>
    panic("Didn't find a suitable machine");
80104025:	83 ec 0c             	sub    $0xc,%esp
80104028:	68 7c 87 10 80       	push   $0x8010877c
8010402d:	e8 4e c3 ff ff       	call   80100380 <panic>
80104032:	66 90                	xchg   %ax,%ax
80104034:	66 90                	xchg   %ax,%ax
80104036:	66 90                	xchg   %ax,%ax
80104038:	66 90                	xchg   %ax,%ax
8010403a:	66 90                	xchg   %ax,%ax
8010403c:	66 90                	xchg   %ax,%ax
8010403e:	66 90                	xchg   %ax,%ax

80104040 <picinit>:
80104040:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104045:	ba 21 00 00 00       	mov    $0x21,%edx
8010404a:	ee                   	out    %al,(%dx)
8010404b:	ba a1 00 00 00       	mov    $0xa1,%edx
80104050:	ee                   	out    %al,(%dx)
80104051:	c3                   	ret    
80104052:	66 90                	xchg   %ax,%ax
80104054:	66 90                	xchg   %ax,%ax
80104056:	66 90                	xchg   %ax,%ax
80104058:	66 90                	xchg   %ax,%ax
8010405a:	66 90                	xchg   %ax,%ax
8010405c:	66 90                	xchg   %ax,%ax
8010405e:	66 90                	xchg   %ax,%ax

80104060 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80104060:	55                   	push   %ebp
80104061:	89 e5                	mov    %esp,%ebp
80104063:	57                   	push   %edi
80104064:	56                   	push   %esi
80104065:	53                   	push   %ebx
80104066:	83 ec 0c             	sub    $0xc,%esp
80104069:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010406c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010406f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80104075:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010407b:	e8 e0 d9 ff ff       	call   80101a60 <filealloc>
80104080:	89 03                	mov    %eax,(%ebx)
80104082:	85 c0                	test   %eax,%eax
80104084:	0f 84 a8 00 00 00    	je     80104132 <pipealloc+0xd2>
8010408a:	e8 d1 d9 ff ff       	call   80101a60 <filealloc>
8010408f:	89 06                	mov    %eax,(%esi)
80104091:	85 c0                	test   %eax,%eax
80104093:	0f 84 87 00 00 00    	je     80104120 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80104099:	e8 12 f2 ff ff       	call   801032b0 <kalloc>
8010409e:	89 c7                	mov    %eax,%edi
801040a0:	85 c0                	test   %eax,%eax
801040a2:	0f 84 b0 00 00 00    	je     80104158 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
801040a8:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801040af:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
801040b2:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
801040b5:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801040bc:	00 00 00 
  p->nwrite = 0;
801040bf:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801040c6:	00 00 00 
  p->nread = 0;
801040c9:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801040d0:	00 00 00 
  initlock(&p->lock, "pipe");
801040d3:	68 9b 87 10 80       	push   $0x8010879b
801040d8:	50                   	push   %eax
801040d9:	e8 42 12 00 00       	call   80105320 <initlock>
  (*f0)->type = FD_PIPE;
801040de:	8b 03                	mov    (%ebx),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
801040e0:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
801040e3:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801040e9:	8b 03                	mov    (%ebx),%eax
801040eb:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801040ef:	8b 03                	mov    (%ebx),%eax
801040f1:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801040f5:	8b 03                	mov    (%ebx),%eax
801040f7:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
801040fa:	8b 06                	mov    (%esi),%eax
801040fc:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80104102:	8b 06                	mov    (%esi),%eax
80104104:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80104108:	8b 06                	mov    (%esi),%eax
8010410a:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
8010410e:	8b 06                	mov    (%esi),%eax
80104110:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80104113:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80104116:	31 c0                	xor    %eax,%eax
}
80104118:	5b                   	pop    %ebx
80104119:	5e                   	pop    %esi
8010411a:	5f                   	pop    %edi
8010411b:	5d                   	pop    %ebp
8010411c:	c3                   	ret    
8010411d:	8d 76 00             	lea    0x0(%esi),%esi
  if(*f0)
80104120:	8b 03                	mov    (%ebx),%eax
80104122:	85 c0                	test   %eax,%eax
80104124:	74 1e                	je     80104144 <pipealloc+0xe4>
    fileclose(*f0);
80104126:	83 ec 0c             	sub    $0xc,%esp
80104129:	50                   	push   %eax
8010412a:	e8 f1 d9 ff ff       	call   80101b20 <fileclose>
8010412f:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80104132:	8b 06                	mov    (%esi),%eax
80104134:	85 c0                	test   %eax,%eax
80104136:	74 0c                	je     80104144 <pipealloc+0xe4>
    fileclose(*f1);
80104138:	83 ec 0c             	sub    $0xc,%esp
8010413b:	50                   	push   %eax
8010413c:	e8 df d9 ff ff       	call   80101b20 <fileclose>
80104141:	83 c4 10             	add    $0x10,%esp
}
80104144:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80104147:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010414c:	5b                   	pop    %ebx
8010414d:	5e                   	pop    %esi
8010414e:	5f                   	pop    %edi
8010414f:	5d                   	pop    %ebp
80104150:	c3                   	ret    
80104151:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
80104158:	8b 03                	mov    (%ebx),%eax
8010415a:	85 c0                	test   %eax,%eax
8010415c:	75 c8                	jne    80104126 <pipealloc+0xc6>
8010415e:	eb d2                	jmp    80104132 <pipealloc+0xd2>

80104160 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80104160:	55                   	push   %ebp
80104161:	89 e5                	mov    %esp,%ebp
80104163:	56                   	push   %esi
80104164:	53                   	push   %ebx
80104165:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104168:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010416b:	83 ec 0c             	sub    $0xc,%esp
8010416e:	53                   	push   %ebx
8010416f:	e8 7c 13 00 00       	call   801054f0 <acquire>
  if(writable){
80104174:	83 c4 10             	add    $0x10,%esp
80104177:	85 f6                	test   %esi,%esi
80104179:	74 65                	je     801041e0 <pipeclose+0x80>
    p->writeopen = 0;
    wakeup(&p->nread);
8010417b:	83 ec 0c             	sub    $0xc,%esp
8010417e:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80104184:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010418b:	00 00 00 
    wakeup(&p->nread);
8010418e:	50                   	push   %eax
8010418f:	e8 7c 0d 00 00       	call   80104f10 <wakeup>
80104194:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80104197:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010419d:	85 d2                	test   %edx,%edx
8010419f:	75 0a                	jne    801041ab <pipeclose+0x4b>
801041a1:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801041a7:	85 c0                	test   %eax,%eax
801041a9:	74 15                	je     801041c0 <pipeclose+0x60>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801041ab:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801041ae:	8d 65 f8             	lea    -0x8(%ebp),%esp
801041b1:	5b                   	pop    %ebx
801041b2:	5e                   	pop    %esi
801041b3:	5d                   	pop    %ebp
    release(&p->lock);
801041b4:	e9 d7 12 00 00       	jmp    80105490 <release>
801041b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
801041c0:	83 ec 0c             	sub    $0xc,%esp
801041c3:	53                   	push   %ebx
801041c4:	e8 c7 12 00 00       	call   80105490 <release>
    kfree((char*)p);
801041c9:	89 5d 08             	mov    %ebx,0x8(%ebp)
801041cc:	83 c4 10             	add    $0x10,%esp
}
801041cf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801041d2:	5b                   	pop    %ebx
801041d3:	5e                   	pop    %esi
801041d4:	5d                   	pop    %ebp
    kfree((char*)p);
801041d5:	e9 16 ef ff ff       	jmp    801030f0 <kfree>
801041da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
801041e0:	83 ec 0c             	sub    $0xc,%esp
801041e3:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
801041e9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801041f0:	00 00 00 
    wakeup(&p->nwrite);
801041f3:	50                   	push   %eax
801041f4:	e8 17 0d 00 00       	call   80104f10 <wakeup>
801041f9:	83 c4 10             	add    $0x10,%esp
801041fc:	eb 99                	jmp    80104197 <pipeclose+0x37>
801041fe:	66 90                	xchg   %ax,%ax

80104200 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80104200:	55                   	push   %ebp
80104201:	89 e5                	mov    %esp,%ebp
80104203:	57                   	push   %edi
80104204:	56                   	push   %esi
80104205:	53                   	push   %ebx
80104206:	83 ec 28             	sub    $0x28,%esp
80104209:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
8010420c:	53                   	push   %ebx
8010420d:	e8 de 12 00 00       	call   801054f0 <acquire>
  for(i = 0; i < n; i++){
80104212:	8b 45 10             	mov    0x10(%ebp),%eax
80104215:	83 c4 10             	add    $0x10,%esp
80104218:	85 c0                	test   %eax,%eax
8010421a:	0f 8e c0 00 00 00    	jle    801042e0 <pipewrite+0xe0>
80104220:	8b 45 0c             	mov    0xc(%ebp),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80104223:	8b 8b 38 02 00 00    	mov    0x238(%ebx),%ecx
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80104229:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
8010422f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80104232:	03 45 10             	add    0x10(%ebp),%eax
80104235:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80104238:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010423e:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80104244:	89 ca                	mov    %ecx,%edx
80104246:	05 00 02 00 00       	add    $0x200,%eax
8010424b:	39 c1                	cmp    %eax,%ecx
8010424d:	74 3f                	je     8010428e <pipewrite+0x8e>
8010424f:	eb 67                	jmp    801042b8 <pipewrite+0xb8>
80104251:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->readopen == 0 || myproc()->killed){
80104258:	e8 83 03 00 00       	call   801045e0 <myproc>
8010425d:	8b 48 24             	mov    0x24(%eax),%ecx
80104260:	85 c9                	test   %ecx,%ecx
80104262:	75 34                	jne    80104298 <pipewrite+0x98>
      wakeup(&p->nread);
80104264:	83 ec 0c             	sub    $0xc,%esp
80104267:	57                   	push   %edi
80104268:	e8 a3 0c 00 00       	call   80104f10 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010426d:	58                   	pop    %eax
8010426e:	5a                   	pop    %edx
8010426f:	53                   	push   %ebx
80104270:	56                   	push   %esi
80104271:	e8 da 0b 00 00       	call   80104e50 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80104276:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010427c:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80104282:	83 c4 10             	add    $0x10,%esp
80104285:	05 00 02 00 00       	add    $0x200,%eax
8010428a:	39 c2                	cmp    %eax,%edx
8010428c:	75 2a                	jne    801042b8 <pipewrite+0xb8>
      if(p->readopen == 0 || myproc()->killed){
8010428e:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80104294:	85 c0                	test   %eax,%eax
80104296:	75 c0                	jne    80104258 <pipewrite+0x58>
        release(&p->lock);
80104298:	83 ec 0c             	sub    $0xc,%esp
8010429b:	53                   	push   %ebx
8010429c:	e8 ef 11 00 00       	call   80105490 <release>
        return -1;
801042a1:	83 c4 10             	add    $0x10,%esp
801042a4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
801042a9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801042ac:	5b                   	pop    %ebx
801042ad:	5e                   	pop    %esi
801042ae:	5f                   	pop    %edi
801042af:	5d                   	pop    %ebp
801042b0:	c3                   	ret    
801042b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801042b8:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801042bb:	8d 4a 01             	lea    0x1(%edx),%ecx
801042be:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801042c4:	89 8b 38 02 00 00    	mov    %ecx,0x238(%ebx)
801042ca:	0f b6 06             	movzbl (%esi),%eax
  for(i = 0; i < n; i++){
801042cd:	83 c6 01             	add    $0x1,%esi
801042d0:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801042d3:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801042d7:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801042da:	0f 85 58 ff ff ff    	jne    80104238 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801042e0:	83 ec 0c             	sub    $0xc,%esp
801042e3:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801042e9:	50                   	push   %eax
801042ea:	e8 21 0c 00 00       	call   80104f10 <wakeup>
  release(&p->lock);
801042ef:	89 1c 24             	mov    %ebx,(%esp)
801042f2:	e8 99 11 00 00       	call   80105490 <release>
  return n;
801042f7:	8b 45 10             	mov    0x10(%ebp),%eax
801042fa:	83 c4 10             	add    $0x10,%esp
801042fd:	eb aa                	jmp    801042a9 <pipewrite+0xa9>
801042ff:	90                   	nop

80104300 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80104300:	55                   	push   %ebp
80104301:	89 e5                	mov    %esp,%ebp
80104303:	57                   	push   %edi
80104304:	56                   	push   %esi
80104305:	53                   	push   %ebx
80104306:	83 ec 18             	sub    $0x18,%esp
80104309:	8b 75 08             	mov    0x8(%ebp),%esi
8010430c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010430f:	56                   	push   %esi
80104310:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80104316:	e8 d5 11 00 00       	call   801054f0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010431b:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80104321:	83 c4 10             	add    $0x10,%esp
80104324:	39 86 38 02 00 00    	cmp    %eax,0x238(%esi)
8010432a:	74 2f                	je     8010435b <piperead+0x5b>
8010432c:	eb 37                	jmp    80104365 <piperead+0x65>
8010432e:	66 90                	xchg   %ax,%ax
    if(myproc()->killed){
80104330:	e8 ab 02 00 00       	call   801045e0 <myproc>
80104335:	8b 48 24             	mov    0x24(%eax),%ecx
80104338:	85 c9                	test   %ecx,%ecx
8010433a:	0f 85 80 00 00 00    	jne    801043c0 <piperead+0xc0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80104340:	83 ec 08             	sub    $0x8,%esp
80104343:	56                   	push   %esi
80104344:	53                   	push   %ebx
80104345:	e8 06 0b 00 00       	call   80104e50 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010434a:	8b 86 38 02 00 00    	mov    0x238(%esi),%eax
80104350:	83 c4 10             	add    $0x10,%esp
80104353:	39 86 34 02 00 00    	cmp    %eax,0x234(%esi)
80104359:	75 0a                	jne    80104365 <piperead+0x65>
8010435b:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
80104361:	85 c0                	test   %eax,%eax
80104363:	75 cb                	jne    80104330 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80104365:	8b 55 10             	mov    0x10(%ebp),%edx
80104368:	31 db                	xor    %ebx,%ebx
8010436a:	85 d2                	test   %edx,%edx
8010436c:	7f 20                	jg     8010438e <piperead+0x8e>
8010436e:	eb 2c                	jmp    8010439c <piperead+0x9c>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80104370:	8d 48 01             	lea    0x1(%eax),%ecx
80104373:	25 ff 01 00 00       	and    $0x1ff,%eax
80104378:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
8010437e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80104383:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80104386:	83 c3 01             	add    $0x1,%ebx
80104389:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010438c:	74 0e                	je     8010439c <piperead+0x9c>
    if(p->nread == p->nwrite)
8010438e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80104394:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010439a:	75 d4                	jne    80104370 <piperead+0x70>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010439c:	83 ec 0c             	sub    $0xc,%esp
8010439f:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
801043a5:	50                   	push   %eax
801043a6:	e8 65 0b 00 00       	call   80104f10 <wakeup>
  release(&p->lock);
801043ab:	89 34 24             	mov    %esi,(%esp)
801043ae:	e8 dd 10 00 00       	call   80105490 <release>
  return i;
801043b3:	83 c4 10             	add    $0x10,%esp
}
801043b6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801043b9:	89 d8                	mov    %ebx,%eax
801043bb:	5b                   	pop    %ebx
801043bc:	5e                   	pop    %esi
801043bd:	5f                   	pop    %edi
801043be:	5d                   	pop    %ebp
801043bf:	c3                   	ret    
      release(&p->lock);
801043c0:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801043c3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
801043c8:	56                   	push   %esi
801043c9:	e8 c2 10 00 00       	call   80105490 <release>
      return -1;
801043ce:	83 c4 10             	add    $0x10,%esp
}
801043d1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801043d4:	89 d8                	mov    %ebx,%eax
801043d6:	5b                   	pop    %ebx
801043d7:	5e                   	pop    %esi
801043d8:	5f                   	pop    %edi
801043d9:	5d                   	pop    %ebp
801043da:	c3                   	ret    
801043db:	66 90                	xchg   %ax,%ax
801043dd:	66 90                	xchg   %ax,%ax
801043df:	90                   	nop

801043e0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801043e0:	55                   	push   %ebp
801043e1:	89 e5                	mov    %esp,%ebp
801043e3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801043e4:	bb 54 37 11 80       	mov    $0x80113754,%ebx
{
801043e9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
801043ec:	68 20 37 11 80       	push   $0x80113720
801043f1:	e8 fa 10 00 00       	call   801054f0 <acquire>
801043f6:	83 c4 10             	add    $0x10,%esp
801043f9:	eb 17                	jmp    80104412 <allocproc+0x32>
801043fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801043ff:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104400:	81 c3 98 00 00 00    	add    $0x98,%ebx
80104406:	81 fb 54 5d 11 80    	cmp    $0x80115d54,%ebx
8010440c:	0f 84 ae 00 00 00    	je     801044c0 <allocproc+0xe0>
    if(p->state == UNUSED)
80104412:	8b 43 0c             	mov    0xc(%ebx),%eax
80104415:	85 c0                	test   %eax,%eax
80104417:	75 e7                	jne    80104400 <allocproc+0x20>
  return 0;

found:
  p->state = EMBRYO;
  p->traced = SYSCALL_UNTRACE; /*Q1 adding default*/
  p->pid = nextpid++;
80104419:	a1 04 b0 10 80       	mov    0x8010b004,%eax
  p->readytime = 0;
  p->runningtime = 0;
  p->sleepingtime = 0;
  
  
  release(&ptable.lock);
8010441e:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
80104421:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->traced = SYSCALL_UNTRACE; /*Q1 adding default*/
80104428:	c7 43 7c 00 00 00 00 	movl   $0x0,0x7c(%ebx)
  p->pid = nextpid++;
8010442f:	8d 50 01             	lea    0x1(%eax),%edx
80104432:	89 43 10             	mov    %eax,0x10(%ebx)
  p->creationtime = ticks; // initialized to current number of clock ticks
80104435:	a1 60 5d 11 80       	mov    0x80115d60,%eax
  p->readytime = 0;
8010443a:	c7 83 88 00 00 00 00 	movl   $0x0,0x88(%ebx)
80104441:	00 00 00 
  p->creationtime = ticks; // initialized to current number of clock ticks
80104444:	89 83 80 00 00 00    	mov    %eax,0x80(%ebx)
  p->runningtime = 0;
8010444a:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80104451:	00 00 00 
  p->sleepingtime = 0;
80104454:	c7 83 84 00 00 00 00 	movl   $0x0,0x84(%ebx)
8010445b:	00 00 00 
  release(&ptable.lock);
8010445e:	68 20 37 11 80       	push   $0x80113720
  p->pid = nextpid++;
80104463:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
  release(&ptable.lock);
80104469:	e8 22 10 00 00       	call   80105490 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
8010446e:	e8 3d ee ff ff       	call   801032b0 <kalloc>
80104473:	83 c4 10             	add    $0x10,%esp
80104476:	89 43 08             	mov    %eax,0x8(%ebx)
80104479:	85 c0                	test   %eax,%eax
8010447b:	74 5c                	je     801044d9 <allocproc+0xf9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
8010447d:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80104483:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80104486:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
8010448b:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
8010448e:	c7 40 14 07 69 10 80 	movl   $0x80106907,0x14(%eax)
  p->context = (struct context*)sp;
80104495:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80104498:	6a 14                	push   $0x14
8010449a:	6a 00                	push   $0x0
8010449c:	50                   	push   %eax
8010449d:	e8 0e 11 00 00       	call   801055b0 <memset>
  p->context->eip = (uint)forkret;
801044a2:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
801044a5:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
801044a8:	c7 40 10 f0 44 10 80 	movl   $0x801044f0,0x10(%eax)
}
801044af:	89 d8                	mov    %ebx,%eax
801044b1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801044b4:	c9                   	leave  
801044b5:	c3                   	ret    
801044b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801044bd:	8d 76 00             	lea    0x0(%esi),%esi
  release(&ptable.lock);
801044c0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
801044c3:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
801044c5:	68 20 37 11 80       	push   $0x80113720
801044ca:	e8 c1 0f 00 00       	call   80105490 <release>
}
801044cf:	89 d8                	mov    %ebx,%eax
  return 0;
801044d1:	83 c4 10             	add    $0x10,%esp
}
801044d4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801044d7:	c9                   	leave  
801044d8:	c3                   	ret    
    p->state = UNUSED;
801044d9:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
801044e0:	31 db                	xor    %ebx,%ebx
}
801044e2:	89 d8                	mov    %ebx,%eax
801044e4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801044e7:	c9                   	leave  
801044e8:	c3                   	ret    
801044e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801044f0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801044f0:	55                   	push   %ebp
801044f1:	89 e5                	mov    %esp,%ebp
801044f3:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801044f6:	68 20 37 11 80       	push   $0x80113720
801044fb:	e8 90 0f 00 00       	call   80105490 <release>

  if (first) {
80104500:	a1 00 b0 10 80       	mov    0x8010b000,%eax
80104505:	83 c4 10             	add    $0x10,%esp
80104508:	85 c0                	test   %eax,%eax
8010450a:	75 04                	jne    80104510 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010450c:	c9                   	leave  
8010450d:	c3                   	ret    
8010450e:	66 90                	xchg   %ax,%ax
    first = 0;
80104510:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
80104517:	00 00 00 
    iinit(ROOTDEV);
8010451a:	83 ec 0c             	sub    $0xc,%esp
8010451d:	6a 01                	push   $0x1
8010451f:	e8 6c dc ff ff       	call   80102190 <iinit>
    initlog(ROOTDEV);
80104524:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010452b:	e8 c0 f3 ff ff       	call   801038f0 <initlog>
}
80104530:	83 c4 10             	add    $0x10,%esp
80104533:	c9                   	leave  
80104534:	c3                   	ret    
80104535:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010453c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104540 <pinit>:
{
80104540:	55                   	push   %ebp
80104541:	89 e5                	mov    %esp,%ebp
80104543:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80104546:	68 a0 87 10 80       	push   $0x801087a0
8010454b:	68 20 37 11 80       	push   $0x80113720
80104550:	e8 cb 0d 00 00       	call   80105320 <initlock>
}
80104555:	83 c4 10             	add    $0x10,%esp
80104558:	c9                   	leave  
80104559:	c3                   	ret    
8010455a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104560 <mycpu>:
{
80104560:	55                   	push   %ebp
80104561:	89 e5                	mov    %esp,%ebp
80104563:	56                   	push   %esi
80104564:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104565:	9c                   	pushf  
80104566:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104567:	f6 c4 02             	test   $0x2,%ah
8010456a:	75 46                	jne    801045b2 <mycpu+0x52>
  apicid = lapicid();
8010456c:	e8 af ef ff ff       	call   80103520 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80104571:	8b 35 84 31 11 80    	mov    0x80113184,%esi
80104577:	85 f6                	test   %esi,%esi
80104579:	7e 2a                	jle    801045a5 <mycpu+0x45>
8010457b:	31 d2                	xor    %edx,%edx
8010457d:	eb 08                	jmp    80104587 <mycpu+0x27>
8010457f:	90                   	nop
80104580:	83 c2 01             	add    $0x1,%edx
80104583:	39 f2                	cmp    %esi,%edx
80104585:	74 1e                	je     801045a5 <mycpu+0x45>
    if (cpus[i].apicid == apicid)
80104587:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
8010458d:	0f b6 99 a0 31 11 80 	movzbl -0x7feece60(%ecx),%ebx
80104594:	39 c3                	cmp    %eax,%ebx
80104596:	75 e8                	jne    80104580 <mycpu+0x20>
}
80104598:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
8010459b:	8d 81 a0 31 11 80    	lea    -0x7feece60(%ecx),%eax
}
801045a1:	5b                   	pop    %ebx
801045a2:	5e                   	pop    %esi
801045a3:	5d                   	pop    %ebp
801045a4:	c3                   	ret    
  panic("unknown apicid\n");
801045a5:	83 ec 0c             	sub    $0xc,%esp
801045a8:	68 a7 87 10 80       	push   $0x801087a7
801045ad:	e8 ce bd ff ff       	call   80100380 <panic>
    panic("mycpu called with interrupts enabled\n");
801045b2:	83 ec 0c             	sub    $0xc,%esp
801045b5:	68 ac 88 10 80       	push   $0x801088ac
801045ba:	e8 c1 bd ff ff       	call   80100380 <panic>
801045bf:	90                   	nop

801045c0 <cpuid>:
cpuid() {
801045c0:	55                   	push   %ebp
801045c1:	89 e5                	mov    %esp,%ebp
801045c3:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
801045c6:	e8 95 ff ff ff       	call   80104560 <mycpu>
}
801045cb:	c9                   	leave  
  return mycpu()-cpus;
801045cc:	2d a0 31 11 80       	sub    $0x801131a0,%eax
801045d1:	c1 f8 04             	sar    $0x4,%eax
801045d4:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
801045da:	c3                   	ret    
801045db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801045df:	90                   	nop

801045e0 <myproc>:
myproc(void) {
801045e0:	55                   	push   %ebp
801045e1:	89 e5                	mov    %esp,%ebp
801045e3:	53                   	push   %ebx
801045e4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
801045e7:	e8 b4 0d 00 00       	call   801053a0 <pushcli>
  c = mycpu();
801045ec:	e8 6f ff ff ff       	call   80104560 <mycpu>
  p = c->proc;
801045f1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801045f7:	e8 f4 0d 00 00       	call   801053f0 <popcli>
}
801045fc:	89 d8                	mov    %ebx,%eax
801045fe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104601:	c9                   	leave  
80104602:	c3                   	ret    
80104603:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010460a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104610 <userinit>:
{
80104610:	55                   	push   %ebp
80104611:	89 e5                	mov    %esp,%ebp
80104613:	53                   	push   %ebx
80104614:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80104617:	e8 c4 fd ff ff       	call   801043e0 <allocproc>
8010461c:	89 c3                	mov    %eax,%ebx
  initproc = p;
8010461e:	a3 54 5d 11 80       	mov    %eax,0x80115d54
  if((p->pgdir = setupkvm()) == 0)
80104623:	e8 e8 38 00 00       	call   80107f10 <setupkvm>
80104628:	89 43 04             	mov    %eax,0x4(%ebx)
8010462b:	85 c0                	test   %eax,%eax
8010462d:	0f 84 c4 00 00 00    	je     801046f7 <userinit+0xe7>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80104633:	83 ec 04             	sub    $0x4,%esp
80104636:	68 2c 00 00 00       	push   $0x2c
8010463b:	68 60 b4 10 80       	push   $0x8010b460
80104640:	50                   	push   %eax
80104641:	e8 7a 35 00 00       	call   80107bc0 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80104646:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80104649:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
8010464f:	6a 4c                	push   $0x4c
80104651:	6a 00                	push   $0x0
80104653:	ff 73 18             	push   0x18(%ebx)
80104656:	e8 55 0f 00 00       	call   801055b0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010465b:	8b 43 18             	mov    0x18(%ebx),%eax
8010465e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80104663:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80104666:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010466b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010466f:	8b 43 18             	mov    0x18(%ebx),%eax
80104672:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80104676:	8b 43 18             	mov    0x18(%ebx),%eax
80104679:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010467d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80104681:	8b 43 18             	mov    0x18(%ebx),%eax
80104684:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80104688:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010468c:	8b 43 18             	mov    0x18(%ebx),%eax
8010468f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80104696:	8b 43 18             	mov    0x18(%ebx),%eax
80104699:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
801046a0:	8b 43 18             	mov    0x18(%ebx),%eax
801046a3:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
801046aa:	8d 43 6c             	lea    0x6c(%ebx),%eax
801046ad:	6a 10                	push   $0x10
801046af:	68 d0 87 10 80       	push   $0x801087d0
801046b4:	50                   	push   %eax
801046b5:	e8 b6 10 00 00       	call   80105770 <safestrcpy>
  p->cwd = namei("/");
801046ba:	c7 04 24 d9 87 10 80 	movl   $0x801087d9,(%esp)
801046c1:	e8 0a e6 ff ff       	call   80102cd0 <namei>
801046c6:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
801046c9:	c7 04 24 20 37 11 80 	movl   $0x80113720,(%esp)
801046d0:	e8 1b 0e 00 00       	call   801054f0 <acquire>
  p->state = RUNNABLE;
801046d5:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  p->traced = SYSCALL_TRACE | SYSCALL_TRACEONBOOT;  // Q1 added condition to always trace during booting
801046dc:	c7 43 7c 09 00 00 00 	movl   $0x9,0x7c(%ebx)
  release(&ptable.lock);
801046e3:	c7 04 24 20 37 11 80 	movl   $0x80113720,(%esp)
801046ea:	e8 a1 0d 00 00       	call   80105490 <release>
}
801046ef:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801046f2:	83 c4 10             	add    $0x10,%esp
801046f5:	c9                   	leave  
801046f6:	c3                   	ret    
    panic("userinit: out of memory?");
801046f7:	83 ec 0c             	sub    $0xc,%esp
801046fa:	68 b7 87 10 80       	push   $0x801087b7
801046ff:	e8 7c bc ff ff       	call   80100380 <panic>
80104704:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010470b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010470f:	90                   	nop

80104710 <growproc>:
{
80104710:	55                   	push   %ebp
80104711:	89 e5                	mov    %esp,%ebp
80104713:	56                   	push   %esi
80104714:	53                   	push   %ebx
80104715:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80104718:	e8 83 0c 00 00       	call   801053a0 <pushcli>
  c = mycpu();
8010471d:	e8 3e fe ff ff       	call   80104560 <mycpu>
  p = c->proc;
80104722:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104728:	e8 c3 0c 00 00       	call   801053f0 <popcli>
  sz = curproc->sz;
8010472d:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
8010472f:	85 f6                	test   %esi,%esi
80104731:	7f 1d                	jg     80104750 <growproc+0x40>
  } else if(n < 0){
80104733:	75 3b                	jne    80104770 <growproc+0x60>
  switchuvm(curproc);
80104735:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80104738:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
8010473a:	53                   	push   %ebx
8010473b:	e8 70 33 00 00       	call   80107ab0 <switchuvm>
  return 0;
80104740:	83 c4 10             	add    $0x10,%esp
80104743:	31 c0                	xor    %eax,%eax
}
80104745:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104748:	5b                   	pop    %ebx
80104749:	5e                   	pop    %esi
8010474a:	5d                   	pop    %ebp
8010474b:	c3                   	ret    
8010474c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104750:	83 ec 04             	sub    $0x4,%esp
80104753:	01 c6                	add    %eax,%esi
80104755:	56                   	push   %esi
80104756:	50                   	push   %eax
80104757:	ff 73 04             	push   0x4(%ebx)
8010475a:	e8 d1 35 00 00       	call   80107d30 <allocuvm>
8010475f:	83 c4 10             	add    $0x10,%esp
80104762:	85 c0                	test   %eax,%eax
80104764:	75 cf                	jne    80104735 <growproc+0x25>
      return -1;
80104766:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010476b:	eb d8                	jmp    80104745 <growproc+0x35>
8010476d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104770:	83 ec 04             	sub    $0x4,%esp
80104773:	01 c6                	add    %eax,%esi
80104775:	56                   	push   %esi
80104776:	50                   	push   %eax
80104777:	ff 73 04             	push   0x4(%ebx)
8010477a:	e8 e1 36 00 00       	call   80107e60 <deallocuvm>
8010477f:	83 c4 10             	add    $0x10,%esp
80104782:	85 c0                	test   %eax,%eax
80104784:	75 af                	jne    80104735 <growproc+0x25>
80104786:	eb de                	jmp    80104766 <growproc+0x56>
80104788:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010478f:	90                   	nop

80104790 <fork>:
{
80104790:	55                   	push   %ebp
80104791:	89 e5                	mov    %esp,%ebp
80104793:	57                   	push   %edi
80104794:	56                   	push   %esi
80104795:	53                   	push   %ebx
80104796:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80104799:	e8 02 0c 00 00       	call   801053a0 <pushcli>
  c = mycpu();
8010479e:	e8 bd fd ff ff       	call   80104560 <mycpu>
  p = c->proc;
801047a3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801047a9:	e8 42 0c 00 00       	call   801053f0 <popcli>
  if((np = allocproc()) == 0){
801047ae:	e8 2d fc ff ff       	call   801043e0 <allocproc>
801047b3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801047b6:	85 c0                	test   %eax,%eax
801047b8:	0f 84 c7 00 00 00    	je     80104885 <fork+0xf5>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
801047be:	83 ec 08             	sub    $0x8,%esp
801047c1:	ff 33                	push   (%ebx)
801047c3:	89 c7                	mov    %eax,%edi
801047c5:	ff 73 04             	push   0x4(%ebx)
801047c8:	e8 33 38 00 00       	call   80108000 <copyuvm>
801047cd:	83 c4 10             	add    $0x10,%esp
801047d0:	89 47 04             	mov    %eax,0x4(%edi)
801047d3:	85 c0                	test   %eax,%eax
801047d5:	0f 84 b1 00 00 00    	je     8010488c <fork+0xfc>
  np->traced = (curproc->traced & SYSCALL_ONFORK) ? curproc->traced : SYSCALL_UNTRACE; // tracing if trace is on esle untrace
801047db:	8b 53 7c             	mov    0x7c(%ebx),%edx
  *np->tf = *curproc->tf;
801047de:	b9 13 00 00 00       	mov    $0x13,%ecx
  np->traced = (curproc->traced & SYSCALL_ONFORK) ? curproc->traced : SYSCALL_UNTRACE; // tracing if trace is on esle untrace
801047e3:	89 d0                	mov    %edx,%eax
801047e5:	83 e0 02             	and    $0x2,%eax
801047e8:	0f 45 c2             	cmovne %edx,%eax
801047eb:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801047ee:	89 42 7c             	mov    %eax,0x7c(%edx)
  np->sz = curproc->sz;
801047f1:	8b 03                	mov    (%ebx),%eax
  *np->tf = *curproc->tf;
801047f3:	8b 7a 18             	mov    0x18(%edx),%edi
  np->parent = curproc;
801047f6:	89 5a 14             	mov    %ebx,0x14(%edx)
  np->sz = curproc->sz;
801047f9:	89 02                	mov    %eax,(%edx)
  *np->tf = *curproc->tf;
801047fb:	8b 73 18             	mov    0x18(%ebx),%esi
801047fe:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80104800:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80104802:	8b 42 18             	mov    0x18(%edx),%eax
80104805:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  for(i = 0; i < NOFILE; i++)
8010480c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[i])
80104810:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80104814:	85 c0                	test   %eax,%eax
80104816:	74 13                	je     8010482b <fork+0x9b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80104818:	83 ec 0c             	sub    $0xc,%esp
8010481b:	50                   	push   %eax
8010481c:	e8 af d2 ff ff       	call   80101ad0 <filedup>
80104821:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80104824:	83 c4 10             	add    $0x10,%esp
80104827:	89 44 b1 28          	mov    %eax,0x28(%ecx,%esi,4)
  for(i = 0; i < NOFILE; i++)
8010482b:	83 c6 01             	add    $0x1,%esi
8010482e:	83 fe 10             	cmp    $0x10,%esi
80104831:	75 dd                	jne    80104810 <fork+0x80>
  np->cwd = idup(curproc->cwd);
80104833:	83 ec 0c             	sub    $0xc,%esp
80104836:	ff 73 68             	push   0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104839:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
8010483c:	e8 3f db ff ff       	call   80102380 <idup>
80104841:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104844:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80104847:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
8010484a:	8d 47 6c             	lea    0x6c(%edi),%eax
8010484d:	6a 10                	push   $0x10
8010484f:	53                   	push   %ebx
80104850:	50                   	push   %eax
80104851:	e8 1a 0f 00 00       	call   80105770 <safestrcpy>
  pid = np->pid;
80104856:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80104859:	c7 04 24 20 37 11 80 	movl   $0x80113720,(%esp)
80104860:	e8 8b 0c 00 00       	call   801054f0 <acquire>
  np->state = RUNNABLE;
80104865:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
8010486c:	c7 04 24 20 37 11 80 	movl   $0x80113720,(%esp)
80104873:	e8 18 0c 00 00       	call   80105490 <release>
  return pid;
80104878:	83 c4 10             	add    $0x10,%esp
}
8010487b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010487e:	89 d8                	mov    %ebx,%eax
80104880:	5b                   	pop    %ebx
80104881:	5e                   	pop    %esi
80104882:	5f                   	pop    %edi
80104883:	5d                   	pop    %ebp
80104884:	c3                   	ret    
    return -1;
80104885:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010488a:	eb ef                	jmp    8010487b <fork+0xeb>
    kfree(np->kstack);
8010488c:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010488f:	83 ec 0c             	sub    $0xc,%esp
80104892:	ff 73 08             	push   0x8(%ebx)
80104895:	e8 56 e8 ff ff       	call   801030f0 <kfree>
    np->kstack = 0;
8010489a:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
801048a1:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
801048a4:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
801048ab:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801048b0:	eb c9                	jmp    8010487b <fork+0xeb>
801048b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801048c0 <scheduler>:
{
801048c0:	55                   	push   %ebp
801048c1:	89 e5                	mov    %esp,%ebp
801048c3:	57                   	push   %edi
801048c4:	56                   	push   %esi
801048c5:	53                   	push   %ebx
801048c6:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
801048c9:	e8 92 fc ff ff       	call   80104560 <mycpu>
  c->proc = 0;
801048ce:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
801048d5:	00 00 00 
  struct cpu *c = mycpu();
801048d8:	89 c6                	mov    %eax,%esi
  c->proc = 0;
801048da:	8d 78 04             	lea    0x4(%eax),%edi
801048dd:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
801048e0:	fb                   	sti    
    acquire(&ptable.lock);
801048e1:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801048e4:	bb 54 37 11 80       	mov    $0x80113754,%ebx
    acquire(&ptable.lock);
801048e9:	68 20 37 11 80       	push   $0x80113720
801048ee:	e8 fd 0b 00 00       	call   801054f0 <acquire>
801048f3:	83 c4 10             	add    $0x10,%esp
801048f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048fd:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->state != RUNNABLE)
80104900:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80104904:	75 33                	jne    80104939 <scheduler+0x79>
      switchuvm(p);
80104906:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80104909:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
8010490f:	53                   	push   %ebx
80104910:	e8 9b 31 00 00       	call   80107ab0 <switchuvm>
      swtch(&(c->scheduler), p->context);
80104915:	58                   	pop    %eax
80104916:	5a                   	pop    %edx
80104917:	ff 73 1c             	push   0x1c(%ebx)
8010491a:	57                   	push   %edi
      p->state = RUNNING;
8010491b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80104922:	e8 a4 0e 00 00       	call   801057cb <swtch>
      switchkvm();
80104927:	e8 74 31 00 00       	call   80107aa0 <switchkvm>
      c->proc = 0;
8010492c:	83 c4 10             	add    $0x10,%esp
8010492f:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80104936:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104939:	81 c3 98 00 00 00    	add    $0x98,%ebx
8010493f:	81 fb 54 5d 11 80    	cmp    $0x80115d54,%ebx
80104945:	75 b9                	jne    80104900 <scheduler+0x40>
    release(&ptable.lock);
80104947:	83 ec 0c             	sub    $0xc,%esp
8010494a:	68 20 37 11 80       	push   $0x80113720
8010494f:	e8 3c 0b 00 00       	call   80105490 <release>
    sti();
80104954:	83 c4 10             	add    $0x10,%esp
80104957:	eb 87                	jmp    801048e0 <scheduler+0x20>
80104959:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104960 <sched>:
{
80104960:	55                   	push   %ebp
80104961:	89 e5                	mov    %esp,%ebp
80104963:	56                   	push   %esi
80104964:	53                   	push   %ebx
  pushcli();
80104965:	e8 36 0a 00 00       	call   801053a0 <pushcli>
  c = mycpu();
8010496a:	e8 f1 fb ff ff       	call   80104560 <mycpu>
  p = c->proc;
8010496f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104975:	e8 76 0a 00 00       	call   801053f0 <popcli>
  if(!holding(&ptable.lock))
8010497a:	83 ec 0c             	sub    $0xc,%esp
8010497d:	68 20 37 11 80       	push   $0x80113720
80104982:	e8 c9 0a 00 00       	call   80105450 <holding>
80104987:	83 c4 10             	add    $0x10,%esp
8010498a:	85 c0                	test   %eax,%eax
8010498c:	74 4f                	je     801049dd <sched+0x7d>
  if(mycpu()->ncli != 1)
8010498e:	e8 cd fb ff ff       	call   80104560 <mycpu>
80104993:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
8010499a:	75 68                	jne    80104a04 <sched+0xa4>
  if(p->state == RUNNING)
8010499c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
801049a0:	74 55                	je     801049f7 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801049a2:	9c                   	pushf  
801049a3:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801049a4:	f6 c4 02             	test   $0x2,%ah
801049a7:	75 41                	jne    801049ea <sched+0x8a>
  intena = mycpu()->intena;
801049a9:	e8 b2 fb ff ff       	call   80104560 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
801049ae:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
801049b1:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
801049b7:	e8 a4 fb ff ff       	call   80104560 <mycpu>
801049bc:	83 ec 08             	sub    $0x8,%esp
801049bf:	ff 70 04             	push   0x4(%eax)
801049c2:	53                   	push   %ebx
801049c3:	e8 03 0e 00 00       	call   801057cb <swtch>
  mycpu()->intena = intena;
801049c8:	e8 93 fb ff ff       	call   80104560 <mycpu>
}
801049cd:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
801049d0:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
801049d6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801049d9:	5b                   	pop    %ebx
801049da:	5e                   	pop    %esi
801049db:	5d                   	pop    %ebp
801049dc:	c3                   	ret    
    panic("sched ptable.lock");
801049dd:	83 ec 0c             	sub    $0xc,%esp
801049e0:	68 db 87 10 80       	push   $0x801087db
801049e5:	e8 96 b9 ff ff       	call   80100380 <panic>
    panic("sched interruptible");
801049ea:	83 ec 0c             	sub    $0xc,%esp
801049ed:	68 07 88 10 80       	push   $0x80108807
801049f2:	e8 89 b9 ff ff       	call   80100380 <panic>
    panic("sched running");
801049f7:	83 ec 0c             	sub    $0xc,%esp
801049fa:	68 f9 87 10 80       	push   $0x801087f9
801049ff:	e8 7c b9 ff ff       	call   80100380 <panic>
    panic("sched locks");
80104a04:	83 ec 0c             	sub    $0xc,%esp
80104a07:	68 ed 87 10 80       	push   $0x801087ed
80104a0c:	e8 6f b9 ff ff       	call   80100380 <panic>
80104a11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a18:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a1f:	90                   	nop

80104a20 <exit>:
{
80104a20:	55                   	push   %ebp
80104a21:	89 e5                	mov    %esp,%ebp
80104a23:	57                   	push   %edi
80104a24:	56                   	push   %esi
80104a25:	53                   	push   %ebx
80104a26:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
80104a29:	e8 b2 fb ff ff       	call   801045e0 <myproc>
  if(curproc == initproc)
80104a2e:	39 05 54 5d 11 80    	cmp    %eax,0x80115d54
80104a34:	0f 84 07 01 00 00    	je     80104b41 <exit+0x121>
80104a3a:	89 c3                	mov    %eax,%ebx
80104a3c:	8d 70 28             	lea    0x28(%eax),%esi
80104a3f:	8d 78 68             	lea    0x68(%eax),%edi
80104a42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd]){
80104a48:	8b 06                	mov    (%esi),%eax
80104a4a:	85 c0                	test   %eax,%eax
80104a4c:	74 12                	je     80104a60 <exit+0x40>
      fileclose(curproc->ofile[fd]);
80104a4e:	83 ec 0c             	sub    $0xc,%esp
80104a51:	50                   	push   %eax
80104a52:	e8 c9 d0 ff ff       	call   80101b20 <fileclose>
      curproc->ofile[fd] = 0;
80104a57:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80104a5d:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
80104a60:	83 c6 04             	add    $0x4,%esi
80104a63:	39 f7                	cmp    %esi,%edi
80104a65:	75 e1                	jne    80104a48 <exit+0x28>
  begin_op();
80104a67:	e8 24 ef ff ff       	call   80103990 <begin_op>
  iput(curproc->cwd);
80104a6c:	83 ec 0c             	sub    $0xc,%esp
80104a6f:	ff 73 68             	push   0x68(%ebx)
80104a72:	e8 69 da ff ff       	call   801024e0 <iput>
  end_op();
80104a77:	e8 84 ef ff ff       	call   80103a00 <end_op>
  curproc->cwd = 0;
80104a7c:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
80104a83:	c7 04 24 20 37 11 80 	movl   $0x80113720,(%esp)
80104a8a:	e8 61 0a 00 00       	call   801054f0 <acquire>
  wakeup1(curproc->parent);
80104a8f:	8b 53 14             	mov    0x14(%ebx),%edx
80104a92:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104a95:	b8 54 37 11 80       	mov    $0x80113754,%eax
80104a9a:	eb 10                	jmp    80104aac <exit+0x8c>
80104a9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104aa0:	05 98 00 00 00       	add    $0x98,%eax
80104aa5:	3d 54 5d 11 80       	cmp    $0x80115d54,%eax
80104aaa:	74 1e                	je     80104aca <exit+0xaa>
    if(p->state == SLEEPING && p->chan == chan)
80104aac:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104ab0:	75 ee                	jne    80104aa0 <exit+0x80>
80104ab2:	3b 50 20             	cmp    0x20(%eax),%edx
80104ab5:	75 e9                	jne    80104aa0 <exit+0x80>
      p->state = RUNNABLE;
80104ab7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104abe:	05 98 00 00 00       	add    $0x98,%eax
80104ac3:	3d 54 5d 11 80       	cmp    $0x80115d54,%eax
80104ac8:	75 e2                	jne    80104aac <exit+0x8c>
      p->parent = initproc;
80104aca:	8b 0d 54 5d 11 80    	mov    0x80115d54,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104ad0:	ba 54 37 11 80       	mov    $0x80113754,%edx
80104ad5:	eb 17                	jmp    80104aee <exit+0xce>
80104ad7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ade:	66 90                	xchg   %ax,%ax
80104ae0:	81 c2 98 00 00 00    	add    $0x98,%edx
80104ae6:	81 fa 54 5d 11 80    	cmp    $0x80115d54,%edx
80104aec:	74 3a                	je     80104b28 <exit+0x108>
    if(p->parent == curproc){
80104aee:	39 5a 14             	cmp    %ebx,0x14(%edx)
80104af1:	75 ed                	jne    80104ae0 <exit+0xc0>
      if(p->state == ZOMBIE)
80104af3:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80104af7:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80104afa:	75 e4                	jne    80104ae0 <exit+0xc0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104afc:	b8 54 37 11 80       	mov    $0x80113754,%eax
80104b01:	eb 11                	jmp    80104b14 <exit+0xf4>
80104b03:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104b07:	90                   	nop
80104b08:	05 98 00 00 00       	add    $0x98,%eax
80104b0d:	3d 54 5d 11 80       	cmp    $0x80115d54,%eax
80104b12:	74 cc                	je     80104ae0 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80104b14:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104b18:	75 ee                	jne    80104b08 <exit+0xe8>
80104b1a:	3b 48 20             	cmp    0x20(%eax),%ecx
80104b1d:	75 e9                	jne    80104b08 <exit+0xe8>
      p->state = RUNNABLE;
80104b1f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80104b26:	eb e0                	jmp    80104b08 <exit+0xe8>
  curproc->state = ZOMBIE;
80104b28:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
80104b2f:	e8 2c fe ff ff       	call   80104960 <sched>
  panic("zombie exit");
80104b34:	83 ec 0c             	sub    $0xc,%esp
80104b37:	68 28 88 10 80       	push   $0x80108828
80104b3c:	e8 3f b8 ff ff       	call   80100380 <panic>
    panic("init exiting");
80104b41:	83 ec 0c             	sub    $0xc,%esp
80104b44:	68 1b 88 10 80       	push   $0x8010881b
80104b49:	e8 32 b8 ff ff       	call   80100380 <panic>
80104b4e:	66 90                	xchg   %ax,%ax

80104b50 <wait>:
{
80104b50:	55                   	push   %ebp
80104b51:	89 e5                	mov    %esp,%ebp
80104b53:	56                   	push   %esi
80104b54:	53                   	push   %ebx
  pushcli();
80104b55:	e8 46 08 00 00       	call   801053a0 <pushcli>
  c = mycpu();
80104b5a:	e8 01 fa ff ff       	call   80104560 <mycpu>
  p = c->proc;
80104b5f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104b65:	e8 86 08 00 00       	call   801053f0 <popcli>
  acquire(&ptable.lock);
80104b6a:	83 ec 0c             	sub    $0xc,%esp
80104b6d:	68 20 37 11 80       	push   $0x80113720
80104b72:	e8 79 09 00 00       	call   801054f0 <acquire>
80104b77:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80104b7a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104b7c:	bb 54 37 11 80       	mov    $0x80113754,%ebx
80104b81:	eb 13                	jmp    80104b96 <wait+0x46>
80104b83:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104b87:	90                   	nop
80104b88:	81 c3 98 00 00 00    	add    $0x98,%ebx
80104b8e:	81 fb 54 5d 11 80    	cmp    $0x80115d54,%ebx
80104b94:	74 1e                	je     80104bb4 <wait+0x64>
      if(p->parent != curproc)
80104b96:	39 73 14             	cmp    %esi,0x14(%ebx)
80104b99:	75 ed                	jne    80104b88 <wait+0x38>
      if(p->state == ZOMBIE){
80104b9b:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80104b9f:	74 5f                	je     80104c00 <wait+0xb0>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104ba1:	81 c3 98 00 00 00    	add    $0x98,%ebx
      havekids = 1;
80104ba7:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104bac:	81 fb 54 5d 11 80    	cmp    $0x80115d54,%ebx
80104bb2:	75 e2                	jne    80104b96 <wait+0x46>
    if(!havekids || curproc->killed){
80104bb4:	85 c0                	test   %eax,%eax
80104bb6:	0f 84 9a 00 00 00    	je     80104c56 <wait+0x106>
80104bbc:	8b 46 24             	mov    0x24(%esi),%eax
80104bbf:	85 c0                	test   %eax,%eax
80104bc1:	0f 85 8f 00 00 00    	jne    80104c56 <wait+0x106>
  pushcli();
80104bc7:	e8 d4 07 00 00       	call   801053a0 <pushcli>
  c = mycpu();
80104bcc:	e8 8f f9 ff ff       	call   80104560 <mycpu>
  p = c->proc;
80104bd1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104bd7:	e8 14 08 00 00       	call   801053f0 <popcli>
  if(p == 0)
80104bdc:	85 db                	test   %ebx,%ebx
80104bde:	0f 84 89 00 00 00    	je     80104c6d <wait+0x11d>
  p->chan = chan;
80104be4:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
80104be7:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104bee:	e8 6d fd ff ff       	call   80104960 <sched>
  p->chan = 0;
80104bf3:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80104bfa:	e9 7b ff ff ff       	jmp    80104b7a <wait+0x2a>
80104bff:	90                   	nop
        kfree(p->kstack);
80104c00:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
80104c03:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104c06:	ff 73 08             	push   0x8(%ebx)
80104c09:	e8 e2 e4 ff ff       	call   801030f0 <kfree>
        p->kstack = 0;
80104c0e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104c15:	5a                   	pop    %edx
80104c16:	ff 73 04             	push   0x4(%ebx)
80104c19:	e8 72 32 00 00       	call   80107e90 <freevm>
        p->pid = 0;
80104c1e:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104c25:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80104c2c:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104c30:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104c37:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80104c3e:	c7 04 24 20 37 11 80 	movl   $0x80113720,(%esp)
80104c45:	e8 46 08 00 00       	call   80105490 <release>
        return pid;
80104c4a:	83 c4 10             	add    $0x10,%esp
}
80104c4d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104c50:	89 f0                	mov    %esi,%eax
80104c52:	5b                   	pop    %ebx
80104c53:	5e                   	pop    %esi
80104c54:	5d                   	pop    %ebp
80104c55:	c3                   	ret    
      release(&ptable.lock);
80104c56:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104c59:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80104c5e:	68 20 37 11 80       	push   $0x80113720
80104c63:	e8 28 08 00 00       	call   80105490 <release>
      return -1;
80104c68:	83 c4 10             	add    $0x10,%esp
80104c6b:	eb e0                	jmp    80104c4d <wait+0xfd>
    panic("sleep");
80104c6d:	83 ec 0c             	sub    $0xc,%esp
80104c70:	68 34 88 10 80       	push   $0x80108834
80104c75:	e8 06 b7 ff ff       	call   80100380 <panic>
80104c7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104c80 <wait2>:
{
80104c80:	55                   	push   %ebp
80104c81:	89 e5                	mov    %esp,%ebp
80104c83:	56                   	push   %esi
80104c84:	53                   	push   %ebx
  pushcli();
80104c85:	e8 16 07 00 00       	call   801053a0 <pushcli>
  c = mycpu();
80104c8a:	e8 d1 f8 ff ff       	call   80104560 <mycpu>
  p = c->proc;
80104c8f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104c95:	e8 56 07 00 00       	call   801053f0 <popcli>
  acquire(&ptable.lock);
80104c9a:	83 ec 0c             	sub    $0xc,%esp
80104c9d:	68 20 37 11 80       	push   $0x80113720
80104ca2:	e8 49 08 00 00       	call   801054f0 <acquire>
80104ca7:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80104caa:	31 c0                	xor    %eax,%eax
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104cac:	bb 54 37 11 80       	mov    $0x80113754,%ebx
80104cb1:	eb 13                	jmp    80104cc6 <wait2+0x46>
80104cb3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104cb7:	90                   	nop
80104cb8:	81 c3 98 00 00 00    	add    $0x98,%ebx
80104cbe:	81 fb 54 5d 11 80    	cmp    $0x80115d54,%ebx
80104cc4:	74 1e                	je     80104ce4 <wait2+0x64>
      if (p->parent != curproc)
80104cc6:	39 73 14             	cmp    %esi,0x14(%ebx)
80104cc9:	75 ed                	jne    80104cb8 <wait2+0x38>
      if (p->state == ZOMBIE)
80104ccb:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80104ccf:	74 5f                	je     80104d30 <wait2+0xb0>
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104cd1:	81 c3 98 00 00 00    	add    $0x98,%ebx
      havekids = 1;
80104cd7:	b8 01 00 00 00       	mov    $0x1,%eax
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104cdc:	81 fb 54 5d 11 80    	cmp    $0x80115d54,%ebx
80104ce2:	75 e2                	jne    80104cc6 <wait2+0x46>
    if (!havekids || curproc->killed)
80104ce4:	85 c0                	test   %eax,%eax
80104ce6:	0f 84 e3 00 00 00    	je     80104dcf <wait2+0x14f>
80104cec:	8b 46 24             	mov    0x24(%esi),%eax
80104cef:	85 c0                	test   %eax,%eax
80104cf1:	0f 85 d8 00 00 00    	jne    80104dcf <wait2+0x14f>
  pushcli();
80104cf7:	e8 a4 06 00 00       	call   801053a0 <pushcli>
  c = mycpu();
80104cfc:	e8 5f f8 ff ff       	call   80104560 <mycpu>
  p = c->proc;
80104d01:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104d07:	e8 e4 06 00 00       	call   801053f0 <popcli>
  if(p == 0)
80104d0c:	85 db                	test   %ebx,%ebx
80104d0e:	0f 84 d2 00 00 00    	je     80104de6 <wait2+0x166>
  p->chan = chan;
80104d14:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
80104d17:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104d1e:	e8 3d fc ff ff       	call   80104960 <sched>
  p->chan = 0;
80104d23:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80104d2a:	e9 7b ff ff ff       	jmp    80104caa <wait2+0x2a>
80104d2f:	90                   	nop
        *readytime = p->readytime;
80104d30:	8b 93 88 00 00 00    	mov    0x88(%ebx),%edx
80104d36:	8b 45 08             	mov    0x8(%ebp),%eax
        kfree(p->kstack);
80104d39:	83 ec 0c             	sub    $0xc,%esp
        *readytime = p->readytime;
80104d3c:	89 10                	mov    %edx,(%eax)
        *runningtime = p->runningtime;
80104d3e:	8b 45 0c             	mov    0xc(%ebp),%eax
80104d41:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80104d47:	89 10                	mov    %edx,(%eax)
        *sleepingtime = p->sleepingtime;
80104d49:	8b 45 10             	mov    0x10(%ebp),%eax
80104d4c:	8b 93 84 00 00 00    	mov    0x84(%ebx),%edx
80104d52:	89 10                	mov    %edx,(%eax)
        pid = p->pid;
80104d54:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104d57:	ff 73 08             	push   0x8(%ebx)
80104d5a:	e8 91 e3 ff ff       	call   801030f0 <kfree>
        p->kstack = 0;
80104d5f:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104d66:	5a                   	pop    %edx
80104d67:	ff 73 04             	push   0x4(%ebx)
80104d6a:	e8 21 31 00 00       	call   80107e90 <freevm>
        p->pid = 0;
80104d6f:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104d76:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80104d7d:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104d81:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104d88:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        p->readytime = 0;
80104d8f:	c7 83 88 00 00 00 00 	movl   $0x0,0x88(%ebx)
80104d96:	00 00 00 
        p->runningtime = 0;
80104d99:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80104da0:	00 00 00 
        p->creationtime = 0;
80104da3:	c7 83 80 00 00 00 00 	movl   $0x0,0x80(%ebx)
80104daa:	00 00 00 
        p->sleepingtime = 0;
80104dad:	c7 83 84 00 00 00 00 	movl   $0x0,0x84(%ebx)
80104db4:	00 00 00 
        release(&ptable.lock);
80104db7:	c7 04 24 20 37 11 80 	movl   $0x80113720,(%esp)
80104dbe:	e8 cd 06 00 00       	call   80105490 <release>
        return pid;
80104dc3:	83 c4 10             	add    $0x10,%esp
}
80104dc6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104dc9:	89 f0                	mov    %esi,%eax
80104dcb:	5b                   	pop    %ebx
80104dcc:	5e                   	pop    %esi
80104dcd:	5d                   	pop    %ebp
80104dce:	c3                   	ret    
      release(&ptable.lock);
80104dcf:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104dd2:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80104dd7:	68 20 37 11 80       	push   $0x80113720
80104ddc:	e8 af 06 00 00       	call   80105490 <release>
      return -1;
80104de1:	83 c4 10             	add    $0x10,%esp
80104de4:	eb e0                	jmp    80104dc6 <wait2+0x146>
    panic("sleep");
80104de6:	83 ec 0c             	sub    $0xc,%esp
80104de9:	68 34 88 10 80       	push   $0x80108834
80104dee:	e8 8d b5 ff ff       	call   80100380 <panic>
80104df3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104dfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104e00 <yield>:
{
80104e00:	55                   	push   %ebp
80104e01:	89 e5                	mov    %esp,%ebp
80104e03:	53                   	push   %ebx
80104e04:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104e07:	68 20 37 11 80       	push   $0x80113720
80104e0c:	e8 df 06 00 00       	call   801054f0 <acquire>
  pushcli();
80104e11:	e8 8a 05 00 00       	call   801053a0 <pushcli>
  c = mycpu();
80104e16:	e8 45 f7 ff ff       	call   80104560 <mycpu>
  p = c->proc;
80104e1b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104e21:	e8 ca 05 00 00       	call   801053f0 <popcli>
  myproc()->state = RUNNABLE;
80104e26:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80104e2d:	e8 2e fb ff ff       	call   80104960 <sched>
  release(&ptable.lock);
80104e32:	c7 04 24 20 37 11 80 	movl   $0x80113720,(%esp)
80104e39:	e8 52 06 00 00       	call   80105490 <release>
}
80104e3e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e41:	83 c4 10             	add    $0x10,%esp
80104e44:	c9                   	leave  
80104e45:	c3                   	ret    
80104e46:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e4d:	8d 76 00             	lea    0x0(%esi),%esi

80104e50 <sleep>:
{
80104e50:	55                   	push   %ebp
80104e51:	89 e5                	mov    %esp,%ebp
80104e53:	57                   	push   %edi
80104e54:	56                   	push   %esi
80104e55:	53                   	push   %ebx
80104e56:	83 ec 0c             	sub    $0xc,%esp
80104e59:	8b 7d 08             	mov    0x8(%ebp),%edi
80104e5c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80104e5f:	e8 3c 05 00 00       	call   801053a0 <pushcli>
  c = mycpu();
80104e64:	e8 f7 f6 ff ff       	call   80104560 <mycpu>
  p = c->proc;
80104e69:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104e6f:	e8 7c 05 00 00       	call   801053f0 <popcli>
  if(p == 0)
80104e74:	85 db                	test   %ebx,%ebx
80104e76:	0f 84 87 00 00 00    	je     80104f03 <sleep+0xb3>
  if(lk == 0)
80104e7c:	85 f6                	test   %esi,%esi
80104e7e:	74 76                	je     80104ef6 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104e80:	81 fe 20 37 11 80    	cmp    $0x80113720,%esi
80104e86:	74 50                	je     80104ed8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104e88:	83 ec 0c             	sub    $0xc,%esp
80104e8b:	68 20 37 11 80       	push   $0x80113720
80104e90:	e8 5b 06 00 00       	call   801054f0 <acquire>
    release(lk);
80104e95:	89 34 24             	mov    %esi,(%esp)
80104e98:	e8 f3 05 00 00       	call   80105490 <release>
  p->chan = chan;
80104e9d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104ea0:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104ea7:	e8 b4 fa ff ff       	call   80104960 <sched>
  p->chan = 0;
80104eac:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80104eb3:	c7 04 24 20 37 11 80 	movl   $0x80113720,(%esp)
80104eba:	e8 d1 05 00 00       	call   80105490 <release>
    acquire(lk);
80104ebf:	89 75 08             	mov    %esi,0x8(%ebp)
80104ec2:	83 c4 10             	add    $0x10,%esp
}
80104ec5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ec8:	5b                   	pop    %ebx
80104ec9:	5e                   	pop    %esi
80104eca:	5f                   	pop    %edi
80104ecb:	5d                   	pop    %ebp
    acquire(lk);
80104ecc:	e9 1f 06 00 00       	jmp    801054f0 <acquire>
80104ed1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80104ed8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104edb:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104ee2:	e8 79 fa ff ff       	call   80104960 <sched>
  p->chan = 0;
80104ee7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80104eee:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ef1:	5b                   	pop    %ebx
80104ef2:	5e                   	pop    %esi
80104ef3:	5f                   	pop    %edi
80104ef4:	5d                   	pop    %ebp
80104ef5:	c3                   	ret    
    panic("sleep without lk");
80104ef6:	83 ec 0c             	sub    $0xc,%esp
80104ef9:	68 3a 88 10 80       	push   $0x8010883a
80104efe:	e8 7d b4 ff ff       	call   80100380 <panic>
    panic("sleep");
80104f03:	83 ec 0c             	sub    $0xc,%esp
80104f06:	68 34 88 10 80       	push   $0x80108834
80104f0b:	e8 70 b4 ff ff       	call   80100380 <panic>

80104f10 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104f10:	55                   	push   %ebp
80104f11:	89 e5                	mov    %esp,%ebp
80104f13:	53                   	push   %ebx
80104f14:	83 ec 10             	sub    $0x10,%esp
80104f17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80104f1a:	68 20 37 11 80       	push   $0x80113720
80104f1f:	e8 cc 05 00 00       	call   801054f0 <acquire>
80104f24:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104f27:	b8 54 37 11 80       	mov    $0x80113754,%eax
80104f2c:	eb 0e                	jmp    80104f3c <wakeup+0x2c>
80104f2e:	66 90                	xchg   %ax,%ax
80104f30:	05 98 00 00 00       	add    $0x98,%eax
80104f35:	3d 54 5d 11 80       	cmp    $0x80115d54,%eax
80104f3a:	74 1e                	je     80104f5a <wakeup+0x4a>
    if(p->state == SLEEPING && p->chan == chan)
80104f3c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104f40:	75 ee                	jne    80104f30 <wakeup+0x20>
80104f42:	3b 58 20             	cmp    0x20(%eax),%ebx
80104f45:	75 e9                	jne    80104f30 <wakeup+0x20>
      p->state = RUNNABLE;
80104f47:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104f4e:	05 98 00 00 00       	add    $0x98,%eax
80104f53:	3d 54 5d 11 80       	cmp    $0x80115d54,%eax
80104f58:	75 e2                	jne    80104f3c <wakeup+0x2c>
  wakeup1(chan);
  release(&ptable.lock);
80104f5a:	c7 45 08 20 37 11 80 	movl   $0x80113720,0x8(%ebp)
}
80104f61:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104f64:	c9                   	leave  
  release(&ptable.lock);
80104f65:	e9 26 05 00 00       	jmp    80105490 <release>
80104f6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104f70 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104f70:	55                   	push   %ebp
80104f71:	89 e5                	mov    %esp,%ebp
80104f73:	53                   	push   %ebx
80104f74:	83 ec 10             	sub    $0x10,%esp
80104f77:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
80104f7a:	68 20 37 11 80       	push   $0x80113720
80104f7f:	e8 6c 05 00 00       	call   801054f0 <acquire>
80104f84:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104f87:	b8 54 37 11 80       	mov    $0x80113754,%eax
80104f8c:	eb 0e                	jmp    80104f9c <kill+0x2c>
80104f8e:	66 90                	xchg   %ax,%ax
80104f90:	05 98 00 00 00       	add    $0x98,%eax
80104f95:	3d 54 5d 11 80       	cmp    $0x80115d54,%eax
80104f9a:	74 34                	je     80104fd0 <kill+0x60>
    if(p->pid == pid){
80104f9c:	39 58 10             	cmp    %ebx,0x10(%eax)
80104f9f:	75 ef                	jne    80104f90 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104fa1:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104fa5:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
80104fac:	75 07                	jne    80104fb5 <kill+0x45>
        p->state = RUNNABLE;
80104fae:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104fb5:	83 ec 0c             	sub    $0xc,%esp
80104fb8:	68 20 37 11 80       	push   $0x80113720
80104fbd:	e8 ce 04 00 00       	call   80105490 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80104fc2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
80104fc5:	83 c4 10             	add    $0x10,%esp
80104fc8:	31 c0                	xor    %eax,%eax
}
80104fca:	c9                   	leave  
80104fcb:	c3                   	ret    
80104fcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80104fd0:	83 ec 0c             	sub    $0xc,%esp
80104fd3:	68 20 37 11 80       	push   $0x80113720
80104fd8:	e8 b3 04 00 00       	call   80105490 <release>
}
80104fdd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80104fe0:	83 c4 10             	add    $0x10,%esp
80104fe3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104fe8:	c9                   	leave  
80104fe9:	c3                   	ret    
80104fea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104ff0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104ff0:	55                   	push   %ebp
80104ff1:	89 e5                	mov    %esp,%ebp
80104ff3:	57                   	push   %edi
80104ff4:	56                   	push   %esi
80104ff5:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104ff8:	53                   	push   %ebx
80104ff9:	bb c0 37 11 80       	mov    $0x801137c0,%ebx
80104ffe:	83 ec 3c             	sub    $0x3c,%esp
80105001:	eb 27                	jmp    8010502a <procdump+0x3a>
80105003:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105007:	90                   	nop
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80105008:	83 ec 0c             	sub    $0xc,%esp
8010500b:	68 c3 8d 10 80       	push   $0x80108dc3
80105010:	e8 7b b7 ff ff       	call   80100790 <cprintf>
80105015:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80105018:	81 c3 98 00 00 00    	add    $0x98,%ebx
8010501e:	81 fb c0 5d 11 80    	cmp    $0x80115dc0,%ebx
80105024:	0f 84 7e 00 00 00    	je     801050a8 <procdump+0xb8>
    if(p->state == UNUSED)
8010502a:	8b 43 a0             	mov    -0x60(%ebx),%eax
8010502d:	85 c0                	test   %eax,%eax
8010502f:	74 e7                	je     80105018 <procdump+0x28>
      state = "???";
80105031:	ba 4b 88 10 80       	mov    $0x8010884b,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80105036:	83 f8 05             	cmp    $0x5,%eax
80105039:	77 11                	ja     8010504c <procdump+0x5c>
8010503b:	8b 14 85 3c 89 10 80 	mov    -0x7fef76c4(,%eax,4),%edx
      state = "???";
80105042:	b8 4b 88 10 80       	mov    $0x8010884b,%eax
80105047:	85 d2                	test   %edx,%edx
80105049:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
8010504c:	53                   	push   %ebx
8010504d:	52                   	push   %edx
8010504e:	ff 73 a4             	push   -0x5c(%ebx)
80105051:	68 4f 88 10 80       	push   $0x8010884f
80105056:	e8 35 b7 ff ff       	call   80100790 <cprintf>
    if(p->state == SLEEPING){
8010505b:	83 c4 10             	add    $0x10,%esp
8010505e:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
80105062:	75 a4                	jne    80105008 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80105064:	83 ec 08             	sub    $0x8,%esp
80105067:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010506a:	8d 7d c0             	lea    -0x40(%ebp),%edi
8010506d:	50                   	push   %eax
8010506e:	8b 43 b0             	mov    -0x50(%ebx),%eax
80105071:	8b 40 0c             	mov    0xc(%eax),%eax
80105074:	83 c0 08             	add    $0x8,%eax
80105077:	50                   	push   %eax
80105078:	e8 c3 02 00 00       	call   80105340 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
8010507d:	83 c4 10             	add    $0x10,%esp
80105080:	8b 17                	mov    (%edi),%edx
80105082:	85 d2                	test   %edx,%edx
80105084:	74 82                	je     80105008 <procdump+0x18>
        cprintf(" %p", pc[i]);
80105086:	83 ec 08             	sub    $0x8,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80105089:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
8010508c:	52                   	push   %edx
8010508d:	68 a1 82 10 80       	push   $0x801082a1
80105092:	e8 f9 b6 ff ff       	call   80100790 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80105097:	83 c4 10             	add    $0x10,%esp
8010509a:	39 fe                	cmp    %edi,%esi
8010509c:	75 e2                	jne    80105080 <procdump+0x90>
8010509e:	e9 65 ff ff ff       	jmp    80105008 <procdump+0x18>
801050a3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801050a7:	90                   	nop
  }
}
801050a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801050ab:	5b                   	pop    %ebx
801050ac:	5e                   	pop    %esi
801050ad:	5f                   	pop    %edi
801050ae:	5d                   	pop    %ebp
801050af:	c3                   	ret    

801050b0 <ps>:

/*Q2 changes made for ps system call*/
int ps(void)
{
801050b0:	55                   	push   %ebp
801050b1:	89 e5                	mov    %esp,%ebp
801050b3:	57                   	push   %edi
801050b4:	56                   	push   %esi
801050b5:	be c0 37 11 80       	mov    $0x801137c0,%esi
801050ba:	53                   	push   %ebx
801050bb:	83 ec 28             	sub    $0x28,%esp
  struct proc *p; // a process of struct type proc

  acquire(&ptable.lock); // acquiring the lock to prevent race condition
801050be:	68 20 37 11 80       	push   $0x80113720
801050c3:	e8 28 04 00 00       	call   801054f0 <acquire>
  cprintf("Name | PID | PPID | Size | State | Waiting  | Killed\n");
801050c8:	c7 04 24 d4 88 10 80 	movl   $0x801088d4,(%esp)
801050cf:	e8 bc b6 ff ff       	call   80100790 <cprintf>

  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801050d4:	83 c4 10             	add    $0x10,%esp
801050d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801050de:	66 90                	xchg   %ax,%ax
  
  // for all the process in the processes table
    if (p->state == UNUSED)
801050e0:	8b 46 a0             	mov    -0x60(%esi),%eax
801050e3:	85 c0                	test   %eax,%eax
801050e5:	74 60                	je     80105147 <ps+0x97>
      continue; // first to check if it is being used or not

    char *state;
    
    if (p->state == SLEEPING)
801050e7:	83 e8 02             	sub    $0x2,%eax
    if (p->state == UNUSED)
801050ea:	bb 58 88 10 80       	mov    $0x80108858,%ebx
801050ef:	83 f8 02             	cmp    $0x2,%eax
801050f2:	77 07                	ja     801050fb <ps+0x4b>
801050f4:	8b 1c 85 30 89 10 80 	mov    -0x7fef76d0(,%eax,4),%ebx
    
    else
      state = "UNKNOWN";
	// after that the state of process is checked!
	
    char *waiting = (p->chan) ? "Yes" : "No";
801050fb:	8b 56 b4             	mov    -0x4c(%esi),%edx
    char *killed = (p->killed) ? "Yes" : "No";
801050fe:	8b 4e b8             	mov    -0x48(%esi),%ecx
    char *waiting = (p->chan) ? "Yes" : "No";
80105101:	b8 64 88 10 80       	mov    $0x80108864,%eax
80105106:	bf 60 88 10 80       	mov    $0x80108860,%edi
8010510b:	85 d2                	test   %edx,%edx
    char *killed = (p->killed) ? "Yes" : "No";
8010510d:	ba 60 88 10 80       	mov    $0x80108860,%edx
    char *waiting = (p->chan) ? "Yes" : "No";
80105112:	0f 44 f8             	cmove  %eax,%edi
    char *killed = (p->killed) ? "Yes" : "No";
80105115:	85 c9                	test   %ecx,%ecx
    	// then it is checked if the process is waiting or killed

    cprintf("%s | %d | %d | %d | %s | %s | %s\n", p->name, p->pid, (p->parent ? p->parent->pid : -1), p->sz, state, waiting, killed);
80105117:	8b 4e a8             	mov    -0x58(%esi),%ecx
    char *killed = (p->killed) ? "Yes" : "No";
8010511a:	0f 45 c2             	cmovne %edx,%eax
    cprintf("%s | %d | %d | %d | %s | %s | %s\n", p->name, p->pid, (p->parent ? p->parent->pid : -1), p->sz, state, waiting, killed);
8010511d:	ba ff ff ff ff       	mov    $0xffffffff,%edx
    char *waiting = (p->chan) ? "Yes" : "No";
80105122:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    cprintf("%s | %d | %d | %d | %s | %s | %s\n", p->name, p->pid, (p->parent ? p->parent->pid : -1), p->sz, state, waiting, killed);
80105125:	8b 7e 94             	mov    -0x6c(%esi),%edi
80105128:	85 c9                	test   %ecx,%ecx
8010512a:	74 03                	je     8010512f <ps+0x7f>
8010512c:	8b 51 10             	mov    0x10(%ecx),%edx
8010512f:	50                   	push   %eax
80105130:	ff 75 e4             	push   -0x1c(%ebp)
80105133:	53                   	push   %ebx
80105134:	57                   	push   %edi
80105135:	52                   	push   %edx
80105136:	ff 76 a4             	push   -0x5c(%esi)
80105139:	56                   	push   %esi
8010513a:	68 0c 89 10 80       	push   $0x8010890c
8010513f:	e8 4c b6 ff ff       	call   80100790 <cprintf>
80105144:	83 c4 20             	add    $0x20,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80105147:	81 c6 98 00 00 00    	add    $0x98,%esi
8010514d:	81 fe c0 5d 11 80    	cmp    $0x80115dc0,%esi
80105153:	75 8b                	jne    801050e0 <ps+0x30>
  }// printing  processes's metrics

  release(&ptable.lock); // releasing the lock
80105155:	83 ec 0c             	sub    $0xc,%esp
80105158:	68 20 37 11 80       	push   $0x80113720
8010515d:	e8 2e 03 00 00       	call   80105490 <release>
  return 0;
}
80105162:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105165:	31 c0                	xor    %eax,%eax
80105167:	5b                   	pop    %ebx
80105168:	5e                   	pop    %esi
80105169:	5f                   	pop    %edi
8010516a:	5d                   	pop    %ebp
8010516b:	c3                   	ret    
8010516c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105170 <updateStatistics>:


/*Q4 changes made*/
void updateStatistics()
{
80105170:	55                   	push   %ebp
80105171:	89 e5                	mov    %esp,%ebp
80105173:	83 ec 14             	sub    $0x14,%esp
  struct proc *p; // for a process of struct proc
  
  acquire(&ptable.lock); // acquire lock to avoid race condition
80105176:	68 20 37 11 80       	push   $0x80113720
8010517b:	e8 70 03 00 00       	call   801054f0 <acquire>
80105180:	83 c4 10             	add    $0x10,%esp
  
  p = ptable.proc; // for first process from process table
80105183:	b8 54 37 11 80       	mov    $0x80113754,%eax
80105188:	eb 23                	jmp    801051ad <updateStatistics+0x3d>
8010518a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  {
    if (p->state == SLEEPING)
    {
      p->sleepingtime++; // enhance the sleeping time if process is sleeping
    }
    else if (p->state == RUNNABLE)
80105190:	83 fa 03             	cmp    $0x3,%edx
80105193:	74 4b                	je     801051e0 <updateStatistics+0x70>
    {
      p->readytime++; //enhance the ready time if process is ready
    }
    else if (p->state == RUNNING)
80105195:	83 fa 04             	cmp    $0x4,%edx
80105198:	75 07                	jne    801051a1 <updateStatistics+0x31>
    {
      p->runningtime++; //enhance the running time if process is running
8010519a:	83 80 8c 00 00 00 01 	addl   $0x1,0x8c(%eax)
    }
    p++; // next process
801051a1:	05 98 00 00 00       	add    $0x98,%eax
  while (p < &ptable.proc[NPROC]) 
801051a6:	3d 54 5d 11 80       	cmp    $0x80115d54,%eax
801051ab:	74 1b                	je     801051c8 <updateStatistics+0x58>
    if (p->state == SLEEPING)
801051ad:	8b 50 0c             	mov    0xc(%eax),%edx
801051b0:	83 fa 02             	cmp    $0x2,%edx
801051b3:	75 db                	jne    80105190 <updateStatistics+0x20>
      p->sleepingtime++; // enhance the sleeping time if process is sleeping
801051b5:	83 80 84 00 00 00 01 	addl   $0x1,0x84(%eax)
    p++; // next process
801051bc:	05 98 00 00 00       	add    $0x98,%eax
  while (p < &ptable.proc[NPROC]) 
801051c1:	3d 54 5d 11 80       	cmp    $0x80115d54,%eax
801051c6:	75 e5                	jne    801051ad <updateStatistics+0x3d>
  }
  release(&ptable.lock);
801051c8:	83 ec 0c             	sub    $0xc,%esp
801051cb:	68 20 37 11 80       	push   $0x80113720
801051d0:	e8 bb 02 00 00       	call   80105490 <release>
}
801051d5:	83 c4 10             	add    $0x10,%esp
801051d8:	c9                   	leave  
801051d9:	c3                   	ret    
801051da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      p->readytime++; //enhance the ready time if process is ready
801051e0:	83 80 88 00 00 00 01 	addl   $0x1,0x88(%eax)
801051e7:	eb b8                	jmp    801051a1 <updateStatistics+0x31>
801051e9:	66 90                	xchg   %ax,%ax
801051eb:	66 90                	xchg   %ax,%ax
801051ed:	66 90                	xchg   %ax,%ax
801051ef:	90                   	nop

801051f0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801051f0:	55                   	push   %ebp
801051f1:	89 e5                	mov    %esp,%ebp
801051f3:	53                   	push   %ebx
801051f4:	83 ec 0c             	sub    $0xc,%esp
801051f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801051fa:	68 54 89 10 80       	push   $0x80108954
801051ff:	8d 43 04             	lea    0x4(%ebx),%eax
80105202:	50                   	push   %eax
80105203:	e8 18 01 00 00       	call   80105320 <initlock>
  lk->name = name;
80105208:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010520b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80105211:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80105214:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010521b:	89 43 38             	mov    %eax,0x38(%ebx)
}
8010521e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105221:	c9                   	leave  
80105222:	c3                   	ret    
80105223:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010522a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105230 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80105230:	55                   	push   %ebp
80105231:	89 e5                	mov    %esp,%ebp
80105233:	56                   	push   %esi
80105234:	53                   	push   %ebx
80105235:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80105238:	8d 73 04             	lea    0x4(%ebx),%esi
8010523b:	83 ec 0c             	sub    $0xc,%esp
8010523e:	56                   	push   %esi
8010523f:	e8 ac 02 00 00       	call   801054f0 <acquire>
  while (lk->locked) {
80105244:	8b 13                	mov    (%ebx),%edx
80105246:	83 c4 10             	add    $0x10,%esp
80105249:	85 d2                	test   %edx,%edx
8010524b:	74 16                	je     80105263 <acquiresleep+0x33>
8010524d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80105250:	83 ec 08             	sub    $0x8,%esp
80105253:	56                   	push   %esi
80105254:	53                   	push   %ebx
80105255:	e8 f6 fb ff ff       	call   80104e50 <sleep>
  while (lk->locked) {
8010525a:	8b 03                	mov    (%ebx),%eax
8010525c:	83 c4 10             	add    $0x10,%esp
8010525f:	85 c0                	test   %eax,%eax
80105261:	75 ed                	jne    80105250 <acquiresleep+0x20>
  }
  lk->locked = 1;
80105263:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80105269:	e8 72 f3 ff ff       	call   801045e0 <myproc>
8010526e:	8b 40 10             	mov    0x10(%eax),%eax
80105271:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80105274:	89 75 08             	mov    %esi,0x8(%ebp)
}
80105277:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010527a:	5b                   	pop    %ebx
8010527b:	5e                   	pop    %esi
8010527c:	5d                   	pop    %ebp
  release(&lk->lk);
8010527d:	e9 0e 02 00 00       	jmp    80105490 <release>
80105282:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105290 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80105290:	55                   	push   %ebp
80105291:	89 e5                	mov    %esp,%ebp
80105293:	56                   	push   %esi
80105294:	53                   	push   %ebx
80105295:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80105298:	8d 73 04             	lea    0x4(%ebx),%esi
8010529b:	83 ec 0c             	sub    $0xc,%esp
8010529e:	56                   	push   %esi
8010529f:	e8 4c 02 00 00       	call   801054f0 <acquire>
  lk->locked = 0;
801052a4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801052aa:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801052b1:	89 1c 24             	mov    %ebx,(%esp)
801052b4:	e8 57 fc ff ff       	call   80104f10 <wakeup>
  release(&lk->lk);
801052b9:	89 75 08             	mov    %esi,0x8(%ebp)
801052bc:	83 c4 10             	add    $0x10,%esp
}
801052bf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801052c2:	5b                   	pop    %ebx
801052c3:	5e                   	pop    %esi
801052c4:	5d                   	pop    %ebp
  release(&lk->lk);
801052c5:	e9 c6 01 00 00       	jmp    80105490 <release>
801052ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801052d0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
801052d0:	55                   	push   %ebp
801052d1:	89 e5                	mov    %esp,%ebp
801052d3:	57                   	push   %edi
801052d4:	31 ff                	xor    %edi,%edi
801052d6:	56                   	push   %esi
801052d7:	53                   	push   %ebx
801052d8:	83 ec 18             	sub    $0x18,%esp
801052db:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
801052de:	8d 73 04             	lea    0x4(%ebx),%esi
801052e1:	56                   	push   %esi
801052e2:	e8 09 02 00 00       	call   801054f0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
801052e7:	8b 03                	mov    (%ebx),%eax
801052e9:	83 c4 10             	add    $0x10,%esp
801052ec:	85 c0                	test   %eax,%eax
801052ee:	75 18                	jne    80105308 <holdingsleep+0x38>
  release(&lk->lk);
801052f0:	83 ec 0c             	sub    $0xc,%esp
801052f3:	56                   	push   %esi
801052f4:	e8 97 01 00 00       	call   80105490 <release>
  return r;
}
801052f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801052fc:	89 f8                	mov    %edi,%eax
801052fe:	5b                   	pop    %ebx
801052ff:	5e                   	pop    %esi
80105300:	5f                   	pop    %edi
80105301:	5d                   	pop    %ebp
80105302:	c3                   	ret    
80105303:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105307:	90                   	nop
  r = lk->locked && (lk->pid == myproc()->pid);
80105308:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
8010530b:	e8 d0 f2 ff ff       	call   801045e0 <myproc>
80105310:	39 58 10             	cmp    %ebx,0x10(%eax)
80105313:	0f 94 c0             	sete   %al
80105316:	0f b6 c0             	movzbl %al,%eax
80105319:	89 c7                	mov    %eax,%edi
8010531b:	eb d3                	jmp    801052f0 <holdingsleep+0x20>
8010531d:	66 90                	xchg   %ax,%ax
8010531f:	90                   	nop

80105320 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80105320:	55                   	push   %ebp
80105321:	89 e5                	mov    %esp,%ebp
80105323:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80105326:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80105329:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010532f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80105332:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80105339:	5d                   	pop    %ebp
8010533a:	c3                   	ret    
8010533b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010533f:	90                   	nop

80105340 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80105340:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80105341:	31 d2                	xor    %edx,%edx
{
80105343:	89 e5                	mov    %esp,%ebp
80105345:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80105346:	8b 45 08             	mov    0x8(%ebp),%eax
{
80105349:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
8010534c:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
8010534f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105350:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80105356:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010535c:	77 1a                	ja     80105378 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010535e:	8b 58 04             	mov    0x4(%eax),%ebx
80105361:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80105364:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80105367:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80105369:	83 fa 0a             	cmp    $0xa,%edx
8010536c:	75 e2                	jne    80105350 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010536e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105371:	c9                   	leave  
80105372:	c3                   	ret    
80105373:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105377:	90                   	nop
  for(; i < 10; i++)
80105378:	8d 04 91             	lea    (%ecx,%edx,4),%eax
8010537b:	8d 51 28             	lea    0x28(%ecx),%edx
8010537e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80105380:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80105386:	83 c0 04             	add    $0x4,%eax
80105389:	39 d0                	cmp    %edx,%eax
8010538b:	75 f3                	jne    80105380 <getcallerpcs+0x40>
}
8010538d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105390:	c9                   	leave  
80105391:	c3                   	ret    
80105392:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801053a0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801053a0:	55                   	push   %ebp
801053a1:	89 e5                	mov    %esp,%ebp
801053a3:	53                   	push   %ebx
801053a4:	83 ec 04             	sub    $0x4,%esp
801053a7:	9c                   	pushf  
801053a8:	5b                   	pop    %ebx
  asm volatile("cli");
801053a9:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
801053aa:	e8 b1 f1 ff ff       	call   80104560 <mycpu>
801053af:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
801053b5:	85 c0                	test   %eax,%eax
801053b7:	74 17                	je     801053d0 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
801053b9:	e8 a2 f1 ff ff       	call   80104560 <mycpu>
801053be:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
801053c5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801053c8:	c9                   	leave  
801053c9:	c3                   	ret    
801053ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    mycpu()->intena = eflags & FL_IF;
801053d0:	e8 8b f1 ff ff       	call   80104560 <mycpu>
801053d5:	81 e3 00 02 00 00    	and    $0x200,%ebx
801053db:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
801053e1:	eb d6                	jmp    801053b9 <pushcli+0x19>
801053e3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801053ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801053f0 <popcli>:

void
popcli(void)
{
801053f0:	55                   	push   %ebp
801053f1:	89 e5                	mov    %esp,%ebp
801053f3:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801053f6:	9c                   	pushf  
801053f7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801053f8:	f6 c4 02             	test   $0x2,%ah
801053fb:	75 35                	jne    80105432 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
801053fd:	e8 5e f1 ff ff       	call   80104560 <mycpu>
80105402:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80105409:	78 34                	js     8010543f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010540b:	e8 50 f1 ff ff       	call   80104560 <mycpu>
80105410:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80105416:	85 d2                	test   %edx,%edx
80105418:	74 06                	je     80105420 <popcli+0x30>
    sti();
}
8010541a:	c9                   	leave  
8010541b:	c3                   	ret    
8010541c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105420:	e8 3b f1 ff ff       	call   80104560 <mycpu>
80105425:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010542b:	85 c0                	test   %eax,%eax
8010542d:	74 eb                	je     8010541a <popcli+0x2a>
  asm volatile("sti");
8010542f:	fb                   	sti    
}
80105430:	c9                   	leave  
80105431:	c3                   	ret    
    panic("popcli - interruptible");
80105432:	83 ec 0c             	sub    $0xc,%esp
80105435:	68 5f 89 10 80       	push   $0x8010895f
8010543a:	e8 41 af ff ff       	call   80100380 <panic>
    panic("popcli");
8010543f:	83 ec 0c             	sub    $0xc,%esp
80105442:	68 76 89 10 80       	push   $0x80108976
80105447:	e8 34 af ff ff       	call   80100380 <panic>
8010544c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105450 <holding>:
{
80105450:	55                   	push   %ebp
80105451:	89 e5                	mov    %esp,%ebp
80105453:	56                   	push   %esi
80105454:	53                   	push   %ebx
80105455:	8b 75 08             	mov    0x8(%ebp),%esi
80105458:	31 db                	xor    %ebx,%ebx
  pushcli();
8010545a:	e8 41 ff ff ff       	call   801053a0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010545f:	8b 06                	mov    (%esi),%eax
80105461:	85 c0                	test   %eax,%eax
80105463:	75 0b                	jne    80105470 <holding+0x20>
  popcli();
80105465:	e8 86 ff ff ff       	call   801053f0 <popcli>
}
8010546a:	89 d8                	mov    %ebx,%eax
8010546c:	5b                   	pop    %ebx
8010546d:	5e                   	pop    %esi
8010546e:	5d                   	pop    %ebp
8010546f:	c3                   	ret    
  r = lock->locked && lock->cpu == mycpu();
80105470:	8b 5e 08             	mov    0x8(%esi),%ebx
80105473:	e8 e8 f0 ff ff       	call   80104560 <mycpu>
80105478:	39 c3                	cmp    %eax,%ebx
8010547a:	0f 94 c3             	sete   %bl
  popcli();
8010547d:	e8 6e ff ff ff       	call   801053f0 <popcli>
  r = lock->locked && lock->cpu == mycpu();
80105482:	0f b6 db             	movzbl %bl,%ebx
}
80105485:	89 d8                	mov    %ebx,%eax
80105487:	5b                   	pop    %ebx
80105488:	5e                   	pop    %esi
80105489:	5d                   	pop    %ebp
8010548a:	c3                   	ret    
8010548b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010548f:	90                   	nop

80105490 <release>:
{
80105490:	55                   	push   %ebp
80105491:	89 e5                	mov    %esp,%ebp
80105493:	56                   	push   %esi
80105494:	53                   	push   %ebx
80105495:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80105498:	e8 03 ff ff ff       	call   801053a0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010549d:	8b 03                	mov    (%ebx),%eax
8010549f:	85 c0                	test   %eax,%eax
801054a1:	75 15                	jne    801054b8 <release+0x28>
  popcli();
801054a3:	e8 48 ff ff ff       	call   801053f0 <popcli>
    panic("release");
801054a8:	83 ec 0c             	sub    $0xc,%esp
801054ab:	68 7d 89 10 80       	push   $0x8010897d
801054b0:	e8 cb ae ff ff       	call   80100380 <panic>
801054b5:	8d 76 00             	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
801054b8:	8b 73 08             	mov    0x8(%ebx),%esi
801054bb:	e8 a0 f0 ff ff       	call   80104560 <mycpu>
801054c0:	39 c6                	cmp    %eax,%esi
801054c2:	75 df                	jne    801054a3 <release+0x13>
  popcli();
801054c4:	e8 27 ff ff ff       	call   801053f0 <popcli>
  lk->pcs[0] = 0;
801054c9:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
801054d0:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
801054d7:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
801054dc:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
801054e2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801054e5:	5b                   	pop    %ebx
801054e6:	5e                   	pop    %esi
801054e7:	5d                   	pop    %ebp
  popcli();
801054e8:	e9 03 ff ff ff       	jmp    801053f0 <popcli>
801054ed:	8d 76 00             	lea    0x0(%esi),%esi

801054f0 <acquire>:
{
801054f0:	55                   	push   %ebp
801054f1:	89 e5                	mov    %esp,%ebp
801054f3:	53                   	push   %ebx
801054f4:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
801054f7:	e8 a4 fe ff ff       	call   801053a0 <pushcli>
  if(holding(lk))
801054fc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
801054ff:	e8 9c fe ff ff       	call   801053a0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80105504:	8b 03                	mov    (%ebx),%eax
80105506:	85 c0                	test   %eax,%eax
80105508:	75 7e                	jne    80105588 <acquire+0x98>
  popcli();
8010550a:	e8 e1 fe ff ff       	call   801053f0 <popcli>
  asm volatile("lock; xchgl %0, %1" :
8010550f:	b9 01 00 00 00       	mov    $0x1,%ecx
80105514:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(xchg(&lk->locked, 1) != 0)
80105518:	8b 55 08             	mov    0x8(%ebp),%edx
8010551b:	89 c8                	mov    %ecx,%eax
8010551d:	f0 87 02             	lock xchg %eax,(%edx)
80105520:	85 c0                	test   %eax,%eax
80105522:	75 f4                	jne    80105518 <acquire+0x28>
  __sync_synchronize();
80105524:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80105529:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010552c:	e8 2f f0 ff ff       	call   80104560 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80105531:	8b 4d 08             	mov    0x8(%ebp),%ecx
  ebp = (uint*)v - 2;
80105534:	89 ea                	mov    %ebp,%edx
  lk->cpu = mycpu();
80105536:	89 43 08             	mov    %eax,0x8(%ebx)
  for(i = 0; i < 10; i++){
80105539:	31 c0                	xor    %eax,%eax
8010553b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010553f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105540:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80105546:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010554c:	77 1a                	ja     80105568 <acquire+0x78>
    pcs[i] = ebp[1];     // saved %eip
8010554e:	8b 5a 04             	mov    0x4(%edx),%ebx
80105551:	89 5c 81 0c          	mov    %ebx,0xc(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
80105555:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
80105558:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
8010555a:	83 f8 0a             	cmp    $0xa,%eax
8010555d:	75 e1                	jne    80105540 <acquire+0x50>
}
8010555f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105562:	c9                   	leave  
80105563:	c3                   	ret    
80105564:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
80105568:	8d 44 81 0c          	lea    0xc(%ecx,%eax,4),%eax
8010556c:	8d 51 34             	lea    0x34(%ecx),%edx
8010556f:	90                   	nop
    pcs[i] = 0;
80105570:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80105576:	83 c0 04             	add    $0x4,%eax
80105579:	39 c2                	cmp    %eax,%edx
8010557b:	75 f3                	jne    80105570 <acquire+0x80>
}
8010557d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105580:	c9                   	leave  
80105581:	c3                   	ret    
80105582:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80105588:	8b 5b 08             	mov    0x8(%ebx),%ebx
8010558b:	e8 d0 ef ff ff       	call   80104560 <mycpu>
80105590:	39 c3                	cmp    %eax,%ebx
80105592:	0f 85 72 ff ff ff    	jne    8010550a <acquire+0x1a>
  popcli();
80105598:	e8 53 fe ff ff       	call   801053f0 <popcli>
    panic("acquire");
8010559d:	83 ec 0c             	sub    $0xc,%esp
801055a0:	68 85 89 10 80       	push   $0x80108985
801055a5:	e8 d6 ad ff ff       	call   80100380 <panic>
801055aa:	66 90                	xchg   %ax,%ax
801055ac:	66 90                	xchg   %ax,%ax
801055ae:	66 90                	xchg   %ax,%ax

801055b0 <memset>:
801055b0:	55                   	push   %ebp
801055b1:	89 e5                	mov    %esp,%ebp
801055b3:	57                   	push   %edi
801055b4:	8b 55 08             	mov    0x8(%ebp),%edx
801055b7:	8b 4d 10             	mov    0x10(%ebp),%ecx
801055ba:	53                   	push   %ebx
801055bb:	8b 45 0c             	mov    0xc(%ebp),%eax
801055be:	89 d7                	mov    %edx,%edi
801055c0:	09 cf                	or     %ecx,%edi
801055c2:	83 e7 03             	and    $0x3,%edi
801055c5:	75 29                	jne    801055f0 <memset+0x40>
801055c7:	0f b6 f8             	movzbl %al,%edi
801055ca:	c1 e0 18             	shl    $0x18,%eax
801055cd:	89 fb                	mov    %edi,%ebx
801055cf:	c1 e9 02             	shr    $0x2,%ecx
801055d2:	c1 e3 10             	shl    $0x10,%ebx
801055d5:	09 d8                	or     %ebx,%eax
801055d7:	09 f8                	or     %edi,%eax
801055d9:	c1 e7 08             	shl    $0x8,%edi
801055dc:	09 f8                	or     %edi,%eax
801055de:	89 d7                	mov    %edx,%edi
801055e0:	fc                   	cld    
801055e1:	f3 ab                	rep stos %eax,%es:(%edi)
801055e3:	5b                   	pop    %ebx
801055e4:	89 d0                	mov    %edx,%eax
801055e6:	5f                   	pop    %edi
801055e7:	5d                   	pop    %ebp
801055e8:	c3                   	ret    
801055e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801055f0:	89 d7                	mov    %edx,%edi
801055f2:	fc                   	cld    
801055f3:	f3 aa                	rep stos %al,%es:(%edi)
801055f5:	5b                   	pop    %ebx
801055f6:	89 d0                	mov    %edx,%eax
801055f8:	5f                   	pop    %edi
801055f9:	5d                   	pop    %ebp
801055fa:	c3                   	ret    
801055fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801055ff:	90                   	nop

80105600 <memcmp>:
80105600:	55                   	push   %ebp
80105601:	89 e5                	mov    %esp,%ebp
80105603:	56                   	push   %esi
80105604:	8b 75 10             	mov    0x10(%ebp),%esi
80105607:	8b 55 08             	mov    0x8(%ebp),%edx
8010560a:	53                   	push   %ebx
8010560b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010560e:	85 f6                	test   %esi,%esi
80105610:	74 2e                	je     80105640 <memcmp+0x40>
80105612:	01 c6                	add    %eax,%esi
80105614:	eb 14                	jmp    8010562a <memcmp+0x2a>
80105616:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010561d:	8d 76 00             	lea    0x0(%esi),%esi
80105620:	83 c0 01             	add    $0x1,%eax
80105623:	83 c2 01             	add    $0x1,%edx
80105626:	39 f0                	cmp    %esi,%eax
80105628:	74 16                	je     80105640 <memcmp+0x40>
8010562a:	0f b6 0a             	movzbl (%edx),%ecx
8010562d:	0f b6 18             	movzbl (%eax),%ebx
80105630:	38 d9                	cmp    %bl,%cl
80105632:	74 ec                	je     80105620 <memcmp+0x20>
80105634:	0f b6 c1             	movzbl %cl,%eax
80105637:	29 d8                	sub    %ebx,%eax
80105639:	5b                   	pop    %ebx
8010563a:	5e                   	pop    %esi
8010563b:	5d                   	pop    %ebp
8010563c:	c3                   	ret    
8010563d:	8d 76 00             	lea    0x0(%esi),%esi
80105640:	5b                   	pop    %ebx
80105641:	31 c0                	xor    %eax,%eax
80105643:	5e                   	pop    %esi
80105644:	5d                   	pop    %ebp
80105645:	c3                   	ret    
80105646:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010564d:	8d 76 00             	lea    0x0(%esi),%esi

80105650 <memmove>:
80105650:	55                   	push   %ebp
80105651:	89 e5                	mov    %esp,%ebp
80105653:	57                   	push   %edi
80105654:	8b 55 08             	mov    0x8(%ebp),%edx
80105657:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010565a:	56                   	push   %esi
8010565b:	8b 75 0c             	mov    0xc(%ebp),%esi
8010565e:	39 d6                	cmp    %edx,%esi
80105660:	73 26                	jae    80105688 <memmove+0x38>
80105662:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
80105665:	39 fa                	cmp    %edi,%edx
80105667:	73 1f                	jae    80105688 <memmove+0x38>
80105669:	8d 41 ff             	lea    -0x1(%ecx),%eax
8010566c:	85 c9                	test   %ecx,%ecx
8010566e:	74 0c                	je     8010567c <memmove+0x2c>
80105670:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80105674:	88 0c 02             	mov    %cl,(%edx,%eax,1)
80105677:	83 e8 01             	sub    $0x1,%eax
8010567a:	73 f4                	jae    80105670 <memmove+0x20>
8010567c:	5e                   	pop    %esi
8010567d:	89 d0                	mov    %edx,%eax
8010567f:	5f                   	pop    %edi
80105680:	5d                   	pop    %ebp
80105681:	c3                   	ret    
80105682:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105688:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
8010568b:	89 d7                	mov    %edx,%edi
8010568d:	85 c9                	test   %ecx,%ecx
8010568f:	74 eb                	je     8010567c <memmove+0x2c>
80105691:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105698:	a4                   	movsb  %ds:(%esi),%es:(%edi)
80105699:	39 c6                	cmp    %eax,%esi
8010569b:	75 fb                	jne    80105698 <memmove+0x48>
8010569d:	5e                   	pop    %esi
8010569e:	89 d0                	mov    %edx,%eax
801056a0:	5f                   	pop    %edi
801056a1:	5d                   	pop    %ebp
801056a2:	c3                   	ret    
801056a3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801056aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801056b0 <memcpy>:
801056b0:	eb 9e                	jmp    80105650 <memmove>
801056b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801056b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801056c0 <strncmp>:
801056c0:	55                   	push   %ebp
801056c1:	89 e5                	mov    %esp,%ebp
801056c3:	56                   	push   %esi
801056c4:	8b 75 10             	mov    0x10(%ebp),%esi
801056c7:	8b 4d 08             	mov    0x8(%ebp),%ecx
801056ca:	53                   	push   %ebx
801056cb:	8b 55 0c             	mov    0xc(%ebp),%edx
801056ce:	85 f6                	test   %esi,%esi
801056d0:	74 2e                	je     80105700 <strncmp+0x40>
801056d2:	01 d6                	add    %edx,%esi
801056d4:	eb 18                	jmp    801056ee <strncmp+0x2e>
801056d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801056dd:	8d 76 00             	lea    0x0(%esi),%esi
801056e0:	38 d8                	cmp    %bl,%al
801056e2:	75 14                	jne    801056f8 <strncmp+0x38>
801056e4:	83 c2 01             	add    $0x1,%edx
801056e7:	83 c1 01             	add    $0x1,%ecx
801056ea:	39 f2                	cmp    %esi,%edx
801056ec:	74 12                	je     80105700 <strncmp+0x40>
801056ee:	0f b6 01             	movzbl (%ecx),%eax
801056f1:	0f b6 1a             	movzbl (%edx),%ebx
801056f4:	84 c0                	test   %al,%al
801056f6:	75 e8                	jne    801056e0 <strncmp+0x20>
801056f8:	29 d8                	sub    %ebx,%eax
801056fa:	5b                   	pop    %ebx
801056fb:	5e                   	pop    %esi
801056fc:	5d                   	pop    %ebp
801056fd:	c3                   	ret    
801056fe:	66 90                	xchg   %ax,%ax
80105700:	5b                   	pop    %ebx
80105701:	31 c0                	xor    %eax,%eax
80105703:	5e                   	pop    %esi
80105704:	5d                   	pop    %ebp
80105705:	c3                   	ret    
80105706:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010570d:	8d 76 00             	lea    0x0(%esi),%esi

80105710 <strncpy>:
80105710:	55                   	push   %ebp
80105711:	89 e5                	mov    %esp,%ebp
80105713:	57                   	push   %edi
80105714:	56                   	push   %esi
80105715:	8b 75 08             	mov    0x8(%ebp),%esi
80105718:	53                   	push   %ebx
80105719:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010571c:	89 f0                	mov    %esi,%eax
8010571e:	eb 15                	jmp    80105735 <strncpy+0x25>
80105720:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80105724:	8b 7d 0c             	mov    0xc(%ebp),%edi
80105727:	83 c0 01             	add    $0x1,%eax
8010572a:	0f b6 57 ff          	movzbl -0x1(%edi),%edx
8010572e:	88 50 ff             	mov    %dl,-0x1(%eax)
80105731:	84 d2                	test   %dl,%dl
80105733:	74 09                	je     8010573e <strncpy+0x2e>
80105735:	89 cb                	mov    %ecx,%ebx
80105737:	83 e9 01             	sub    $0x1,%ecx
8010573a:	85 db                	test   %ebx,%ebx
8010573c:	7f e2                	jg     80105720 <strncpy+0x10>
8010573e:	89 c2                	mov    %eax,%edx
80105740:	85 c9                	test   %ecx,%ecx
80105742:	7e 17                	jle    8010575b <strncpy+0x4b>
80105744:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105748:	83 c2 01             	add    $0x1,%edx
8010574b:	89 c1                	mov    %eax,%ecx
8010574d:	c6 42 ff 00          	movb   $0x0,-0x1(%edx)
80105751:	29 d1                	sub    %edx,%ecx
80105753:	8d 4c 0b ff          	lea    -0x1(%ebx,%ecx,1),%ecx
80105757:	85 c9                	test   %ecx,%ecx
80105759:	7f ed                	jg     80105748 <strncpy+0x38>
8010575b:	5b                   	pop    %ebx
8010575c:	89 f0                	mov    %esi,%eax
8010575e:	5e                   	pop    %esi
8010575f:	5f                   	pop    %edi
80105760:	5d                   	pop    %ebp
80105761:	c3                   	ret    
80105762:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105770 <safestrcpy>:
80105770:	55                   	push   %ebp
80105771:	89 e5                	mov    %esp,%ebp
80105773:	56                   	push   %esi
80105774:	8b 55 10             	mov    0x10(%ebp),%edx
80105777:	8b 75 08             	mov    0x8(%ebp),%esi
8010577a:	53                   	push   %ebx
8010577b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010577e:	85 d2                	test   %edx,%edx
80105780:	7e 25                	jle    801057a7 <safestrcpy+0x37>
80105782:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80105786:	89 f2                	mov    %esi,%edx
80105788:	eb 16                	jmp    801057a0 <safestrcpy+0x30>
8010578a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105790:	0f b6 08             	movzbl (%eax),%ecx
80105793:	83 c0 01             	add    $0x1,%eax
80105796:	83 c2 01             	add    $0x1,%edx
80105799:	88 4a ff             	mov    %cl,-0x1(%edx)
8010579c:	84 c9                	test   %cl,%cl
8010579e:	74 04                	je     801057a4 <safestrcpy+0x34>
801057a0:	39 d8                	cmp    %ebx,%eax
801057a2:	75 ec                	jne    80105790 <safestrcpy+0x20>
801057a4:	c6 02 00             	movb   $0x0,(%edx)
801057a7:	89 f0                	mov    %esi,%eax
801057a9:	5b                   	pop    %ebx
801057aa:	5e                   	pop    %esi
801057ab:	5d                   	pop    %ebp
801057ac:	c3                   	ret    
801057ad:	8d 76 00             	lea    0x0(%esi),%esi

801057b0 <strlen>:
801057b0:	55                   	push   %ebp
801057b1:	31 c0                	xor    %eax,%eax
801057b3:	89 e5                	mov    %esp,%ebp
801057b5:	8b 55 08             	mov    0x8(%ebp),%edx
801057b8:	80 3a 00             	cmpb   $0x0,(%edx)
801057bb:	74 0c                	je     801057c9 <strlen+0x19>
801057bd:	8d 76 00             	lea    0x0(%esi),%esi
801057c0:	83 c0 01             	add    $0x1,%eax
801057c3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
801057c7:	75 f7                	jne    801057c0 <strlen+0x10>
801057c9:	5d                   	pop    %ebp
801057ca:	c3                   	ret    

801057cb <swtch>:
801057cb:	8b 44 24 04          	mov    0x4(%esp),%eax
801057cf:	8b 54 24 08          	mov    0x8(%esp),%edx
801057d3:	55                   	push   %ebp
801057d4:	53                   	push   %ebx
801057d5:	56                   	push   %esi
801057d6:	57                   	push   %edi
801057d7:	89 20                	mov    %esp,(%eax)
801057d9:	89 d4                	mov    %edx,%esp
801057db:	5f                   	pop    %edi
801057dc:	5e                   	pop    %esi
801057dd:	5b                   	pop    %ebx
801057de:	5d                   	pop    %ebp
801057df:	c3                   	ret    

801057e0 <sys_trace>:
extern int sys_wait2(void);


/*Changes for Q1 start*/

int sys_trace() {
801057e0:	55                   	push   %ebp
801057e1:	89 e5                	mov    %esp,%ebp
801057e3:	56                   	push   %esi
801057e4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801057e5:	e8 f6 ed ff ff       	call   801045e0 <myproc>
801057ea:	8b 40 18             	mov    0x18(%eax),%eax
801057ed:	8b 58 44             	mov    0x44(%eax),%ebx
  struct proc *curproc = myproc();
801057f0:	e8 eb ed ff ff       	call   801045e0 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801057f5:	8b 00                	mov    (%eax),%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801057f7:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801057fa:	39 c6                	cmp    %eax,%esi
801057fc:	73 0f                	jae    8010580d <sys_trace+0x2d>
801057fe:	8d 53 08             	lea    0x8(%ebx),%edx
80105801:	39 d0                	cmp    %edx,%eax
80105803:	72 08                	jb     8010580d <sys_trace+0x2d>
  *ip = *(int*)(addr);
80105805:	8b 43 04             	mov    0x4(%ebx),%eax
80105808:	a3 58 5d 11 80       	mov    %eax,0x80115d58
	static int n; // nth 32-bit system call argument.
	argint(0, &n);
	struct proc *curproc = myproc();
8010580d:	e8 ce ed ff ff       	call   801045e0 <myproc>
	curproc->traced = (n & SYSCALL_TRACE) ? n : 0; // Procedure for trace system call that runs in kernel if flag SYSCALL_TRACE is true
80105812:	8b 15 58 5d 11 80    	mov    0x80115d58,%edx
	struct proc *curproc = myproc();
80105818:	89 c1                	mov    %eax,%ecx
	curproc->traced = (n & SYSCALL_TRACE) ? n : 0; // Procedure for trace system call that runs in kernel if flag SYSCALL_TRACE is true
8010581a:	89 d0                	mov    %edx,%eax
8010581c:	83 e0 01             	and    $0x1,%eax
8010581f:	0f 45 c2             	cmovne %edx,%eax
80105822:	89 41 7c             	mov    %eax,0x7c(%ecx)
	return 0;
}
80105825:	31 c0                	xor    %eax,%eax
80105827:	5b                   	pop    %ebx
80105828:	5e                   	pop    %esi
80105829:	5d                   	pop    %ebp
8010582a:	c3                   	ret    
8010582b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010582f:	90                   	nop

80105830 <fetchint>:
{
80105830:	55                   	push   %ebp
80105831:	89 e5                	mov    %esp,%ebp
80105833:	53                   	push   %ebx
80105834:	83 ec 04             	sub    $0x4,%esp
80105837:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010583a:	e8 a1 ed ff ff       	call   801045e0 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010583f:	8b 00                	mov    (%eax),%eax
80105841:	39 d8                	cmp    %ebx,%eax
80105843:	76 1b                	jbe    80105860 <fetchint+0x30>
80105845:	8d 53 04             	lea    0x4(%ebx),%edx
80105848:	39 d0                	cmp    %edx,%eax
8010584a:	72 14                	jb     80105860 <fetchint+0x30>
  *ip = *(int*)(addr);
8010584c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010584f:	8b 13                	mov    (%ebx),%edx
80105851:	89 10                	mov    %edx,(%eax)
  return 0;
80105853:	31 c0                	xor    %eax,%eax
}
80105855:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105858:	c9                   	leave  
80105859:	c3                   	ret    
8010585a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80105860:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105865:	eb ee                	jmp    80105855 <fetchint+0x25>
80105867:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010586e:	66 90                	xchg   %ax,%ax

80105870 <fetchstr>:
{
80105870:	55                   	push   %ebp
80105871:	89 e5                	mov    %esp,%ebp
80105873:	53                   	push   %ebx
80105874:	83 ec 04             	sub    $0x4,%esp
80105877:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010587a:	e8 61 ed ff ff       	call   801045e0 <myproc>
  if(addr >= curproc->sz)
8010587f:	39 18                	cmp    %ebx,(%eax)
80105881:	76 2d                	jbe    801058b0 <fetchstr+0x40>
  *pp = (char*)addr;
80105883:	8b 55 0c             	mov    0xc(%ebp),%edx
80105886:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80105888:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
8010588a:	39 d3                	cmp    %edx,%ebx
8010588c:	73 22                	jae    801058b0 <fetchstr+0x40>
8010588e:	89 d8                	mov    %ebx,%eax
80105890:	eb 0d                	jmp    8010589f <fetchstr+0x2f>
80105892:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105898:	83 c0 01             	add    $0x1,%eax
8010589b:	39 c2                	cmp    %eax,%edx
8010589d:	76 11                	jbe    801058b0 <fetchstr+0x40>
    if(*s == 0)
8010589f:	80 38 00             	cmpb   $0x0,(%eax)
801058a2:	75 f4                	jne    80105898 <fetchstr+0x28>
      return s - *pp;
801058a4:	29 d8                	sub    %ebx,%eax
}
801058a6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801058a9:	c9                   	leave  
801058aa:	c3                   	ret    
801058ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801058af:	90                   	nop
801058b0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
801058b3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801058b8:	c9                   	leave  
801058b9:	c3                   	ret    
801058ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801058c0 <argint>:
{
801058c0:	55                   	push   %ebp
801058c1:	89 e5                	mov    %esp,%ebp
801058c3:	56                   	push   %esi
801058c4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801058c5:	e8 16 ed ff ff       	call   801045e0 <myproc>
801058ca:	8b 55 08             	mov    0x8(%ebp),%edx
801058cd:	8b 40 18             	mov    0x18(%eax),%eax
801058d0:	8b 40 44             	mov    0x44(%eax),%eax
801058d3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
801058d6:	e8 05 ed ff ff       	call   801045e0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801058db:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801058de:	8b 00                	mov    (%eax),%eax
801058e0:	39 c6                	cmp    %eax,%esi
801058e2:	73 1c                	jae    80105900 <argint+0x40>
801058e4:	8d 53 08             	lea    0x8(%ebx),%edx
801058e7:	39 d0                	cmp    %edx,%eax
801058e9:	72 15                	jb     80105900 <argint+0x40>
  *ip = *(int*)(addr);
801058eb:	8b 45 0c             	mov    0xc(%ebp),%eax
801058ee:	8b 53 04             	mov    0x4(%ebx),%edx
801058f1:	89 10                	mov    %edx,(%eax)
  return 0;
801058f3:	31 c0                	xor    %eax,%eax
}
801058f5:	5b                   	pop    %ebx
801058f6:	5e                   	pop    %esi
801058f7:	5d                   	pop    %ebp
801058f8:	c3                   	ret    
801058f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105900:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105905:	eb ee                	jmp    801058f5 <argint+0x35>
80105907:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010590e:	66 90                	xchg   %ax,%ax

80105910 <argptr>:
{
80105910:	55                   	push   %ebp
80105911:	89 e5                	mov    %esp,%ebp
80105913:	57                   	push   %edi
80105914:	56                   	push   %esi
80105915:	53                   	push   %ebx
80105916:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
80105919:	e8 c2 ec ff ff       	call   801045e0 <myproc>
8010591e:	89 c6                	mov    %eax,%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105920:	e8 bb ec ff ff       	call   801045e0 <myproc>
80105925:	8b 55 08             	mov    0x8(%ebp),%edx
80105928:	8b 40 18             	mov    0x18(%eax),%eax
8010592b:	8b 40 44             	mov    0x44(%eax),%eax
8010592e:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105931:	e8 aa ec ff ff       	call   801045e0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105936:	8d 7b 04             	lea    0x4(%ebx),%edi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105939:	8b 00                	mov    (%eax),%eax
8010593b:	39 c7                	cmp    %eax,%edi
8010593d:	73 31                	jae    80105970 <argptr+0x60>
8010593f:	8d 4b 08             	lea    0x8(%ebx),%ecx
80105942:	39 c8                	cmp    %ecx,%eax
80105944:	72 2a                	jb     80105970 <argptr+0x60>
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80105946:	8b 55 10             	mov    0x10(%ebp),%edx
  *ip = *(int*)(addr);
80105949:	8b 43 04             	mov    0x4(%ebx),%eax
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
8010594c:	85 d2                	test   %edx,%edx
8010594e:	78 20                	js     80105970 <argptr+0x60>
80105950:	8b 16                	mov    (%esi),%edx
80105952:	39 c2                	cmp    %eax,%edx
80105954:	76 1a                	jbe    80105970 <argptr+0x60>
80105956:	8b 5d 10             	mov    0x10(%ebp),%ebx
80105959:	01 c3                	add    %eax,%ebx
8010595b:	39 da                	cmp    %ebx,%edx
8010595d:	72 11                	jb     80105970 <argptr+0x60>
  *pp = (char*)i;
8010595f:	8b 55 0c             	mov    0xc(%ebp),%edx
80105962:	89 02                	mov    %eax,(%edx)
  return 0;
80105964:	31 c0                	xor    %eax,%eax
}
80105966:	83 c4 0c             	add    $0xc,%esp
80105969:	5b                   	pop    %ebx
8010596a:	5e                   	pop    %esi
8010596b:	5f                   	pop    %edi
8010596c:	5d                   	pop    %ebp
8010596d:	c3                   	ret    
8010596e:	66 90                	xchg   %ax,%ax
    return -1;
80105970:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105975:	eb ef                	jmp    80105966 <argptr+0x56>
80105977:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010597e:	66 90                	xchg   %ax,%ax

80105980 <argstr>:
{
80105980:	55                   	push   %ebp
80105981:	89 e5                	mov    %esp,%ebp
80105983:	56                   	push   %esi
80105984:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105985:	e8 56 ec ff ff       	call   801045e0 <myproc>
8010598a:	8b 55 08             	mov    0x8(%ebp),%edx
8010598d:	8b 40 18             	mov    0x18(%eax),%eax
80105990:	8b 40 44             	mov    0x44(%eax),%eax
80105993:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105996:	e8 45 ec ff ff       	call   801045e0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010599b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010599e:	8b 00                	mov    (%eax),%eax
801059a0:	39 c6                	cmp    %eax,%esi
801059a2:	73 44                	jae    801059e8 <argstr+0x68>
801059a4:	8d 53 08             	lea    0x8(%ebx),%edx
801059a7:	39 d0                	cmp    %edx,%eax
801059a9:	72 3d                	jb     801059e8 <argstr+0x68>
  *ip = *(int*)(addr);
801059ab:	8b 5b 04             	mov    0x4(%ebx),%ebx
  struct proc *curproc = myproc();
801059ae:	e8 2d ec ff ff       	call   801045e0 <myproc>
  if(addr >= curproc->sz)
801059b3:	3b 18                	cmp    (%eax),%ebx
801059b5:	73 31                	jae    801059e8 <argstr+0x68>
  *pp = (char*)addr;
801059b7:	8b 55 0c             	mov    0xc(%ebp),%edx
801059ba:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
801059bc:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
801059be:	39 d3                	cmp    %edx,%ebx
801059c0:	73 26                	jae    801059e8 <argstr+0x68>
801059c2:	89 d8                	mov    %ebx,%eax
801059c4:	eb 11                	jmp    801059d7 <argstr+0x57>
801059c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801059cd:	8d 76 00             	lea    0x0(%esi),%esi
801059d0:	83 c0 01             	add    $0x1,%eax
801059d3:	39 c2                	cmp    %eax,%edx
801059d5:	76 11                	jbe    801059e8 <argstr+0x68>
    if(*s == 0)
801059d7:	80 38 00             	cmpb   $0x0,(%eax)
801059da:	75 f4                	jne    801059d0 <argstr+0x50>
      return s - *pp;
801059dc:	29 d8                	sub    %ebx,%eax
}
801059de:	5b                   	pop    %ebx
801059df:	5e                   	pop    %esi
801059e0:	5d                   	pop    %ebp
801059e1:	c3                   	ret    
801059e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801059e8:	5b                   	pop    %ebx
    return -1;
801059e9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801059ee:	5e                   	pop    %esi
801059ef:	5d                   	pop    %ebp
801059f0:	c3                   	ret    
801059f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801059f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801059ff:	90                   	nop

80105a00 <syscall>:
[SYS_wait2]    "wait2",
};

void
syscall(void)
{
80105a00:	55                   	push   %ebp
80105a01:	89 e5                	mov    %esp,%ebp
80105a03:	57                   	push   %edi
80105a04:	56                   	push   %esi
80105a05:	53                   	push   %ebx
80105a06:	83 ec 1c             	sub    $0x1c,%esp
  int num, i;
  struct proc *curproc = myproc();
80105a09:	e8 d2 eb ff ff       	call   801045e0 <myproc>
  
  int is_traced = (curproc->traced & SYSCALL_TRACE);
  
  char procname[16];

  for(i=0; curproc->name[i] != 0; i++) {
80105a0e:	0f b6 50 6c          	movzbl 0x6c(%eax),%edx
  int is_traced = (curproc->traced & SYSCALL_TRACE);
80105a12:	8b 78 7c             	mov    0x7c(%eax),%edi
  struct proc *curproc = myproc();
80105a15:	89 c3                	mov    %eax,%ebx
  for(i=0; curproc->name[i] != 0; i++) {
80105a17:	31 c0                	xor    %eax,%eax
80105a19:	84 d2                	test   %dl,%dl
80105a1b:	74 13                	je     80105a30 <syscall+0x30>
80105a1d:	8d 76 00             	lea    0x0(%esi),%esi
    procname[i] = curproc->name[i];
80105a20:	88 54 05 d8          	mov    %dl,-0x28(%ebp,%eax,1)
  for(i=0; curproc->name[i] != 0; i++) {
80105a24:	83 c0 01             	add    $0x1,%eax
80105a27:	0f b6 54 03 6c       	movzbl 0x6c(%ebx,%eax,1),%edx
80105a2c:	84 d2                	test   %dl,%dl
80105a2e:	75 f0                	jne    80105a20 <syscall+0x20>
  }
  procname[i] = curproc->name[i];
80105a30:	c6 44 05 d8 00       	movb   $0x0,-0x28(%ebp,%eax,1)

  num = curproc->tf->eax;
80105a35:	8b 43 18             	mov    0x18(%ebx),%eax
80105a38:	8b 70 1c             	mov    0x1c(%eax),%esi
  //}
  
  
  /*Handling other cases that actially give return value*/
  
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) 
80105a3b:	8d 46 ff             	lea    -0x1(%esi),%eax
80105a3e:	83 f8 18             	cmp    $0x18,%eax
80105a41:	77 55                	ja     80105a98 <syscall+0x98>
80105a43:	8b 04 b5 20 8b 10 80 	mov    -0x7fef74e0(,%esi,4),%eax
80105a4a:	85 c0                	test   %eax,%eax
80105a4c:	74 4a                	je     80105a98 <syscall+0x98>
  {
    curproc->tf->eax = syscalls[num](); // making sure that valid system call has been made
80105a4e:	ff d0                	call   *%eax
80105a50:	8b 53 18             	mov    0x18(%ebx),%edx
    
    if (is_traced) {
80105a53:	83 e7 01             	and    $0x1,%edi
    curproc->tf->eax = syscalls[num](); // making sure that valid system call has been made
80105a56:	89 42 1c             	mov    %eax,0x1c(%edx)
    if (is_traced) {
80105a59:	74 5c                	je     80105ab7 <syscall+0xb7>
      
      cprintf((num == SYS_exec && curproc->tf->eax == 0) ?
80105a5b:	8b 43 18             	mov    0x18(%ebx),%eax
80105a5e:	8b 0c b5 a0 8a 10 80 	mov    -0x7fef7560(,%esi,4),%ecx
80105a65:	8b 5b 10             	mov    0x10(%ebx),%ebx
80105a68:	8b 40 1c             	mov    0x1c(%eax),%eax
80105a6b:	85 c0                	test   %eax,%eax
80105a6d:	75 50                	jne    80105abf <syscall+0xbf>
80105a6f:	ba 90 89 10 80       	mov    $0x80108990,%edx
80105a74:	83 fe 07             	cmp    $0x7,%esi
80105a77:	75 46                	jne    80105abf <syscall+0xbf>
80105a79:	83 ec 0c             	sub    $0xc,%esp
80105a7c:	50                   	push   %eax
80105a7d:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105a80:	50                   	push   %eax
80105a81:	53                   	push   %ebx
80105a82:	51                   	push   %ecx
80105a83:	52                   	push   %edx
80105a84:	e8 07 ad ff ff       	call   80100790 <cprintf>
80105a89:	83 c4 20             	add    $0x20,%esp
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80105a8c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a8f:	5b                   	pop    %ebx
80105a90:	5e                   	pop    %esi
80105a91:	5f                   	pop    %edi
80105a92:	5d                   	pop    %ebp
80105a93:	c3                   	ret    
80105a94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            curproc->pid, curproc->name, num);
80105a98:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80105a9b:	56                   	push   %esi
80105a9c:	50                   	push   %eax
80105a9d:	ff 73 10             	push   0x10(%ebx)
80105aa0:	68 18 8a 10 80       	push   $0x80108a18
80105aa5:	e8 e6 ac ff ff       	call   80100790 <cprintf>
    curproc->tf->eax = -1;
80105aaa:	8b 43 18             	mov    0x18(%ebx),%eax
80105aad:	83 c4 10             	add    $0x10,%esp
80105ab0:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80105ab7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105aba:	5b                   	pop    %ebx
80105abb:	5e                   	pop    %esi
80105abc:	5f                   	pop    %edi
80105abd:	5d                   	pop    %ebp
80105abe:	c3                   	ret    
      cprintf((num == SYS_exec && curproc->tf->eax == 0) ?
80105abf:	ba cc 89 10 80       	mov    $0x801089cc,%edx
80105ac4:	eb b3                	jmp    80105a79 <syscall+0x79>
80105ac6:	66 90                	xchg   %ax,%ax
80105ac8:	66 90                	xchg   %ax,%ax
80105aca:	66 90                	xchg   %ax,%ax
80105acc:	66 90                	xchg   %ax,%ax
80105ace:	66 90                	xchg   %ax,%ax

80105ad0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80105ad0:	55                   	push   %ebp
80105ad1:	89 e5                	mov    %esp,%ebp
80105ad3:	57                   	push   %edi
80105ad4:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105ad5:	8d 7d da             	lea    -0x26(%ebp),%edi
{
80105ad8:	53                   	push   %ebx
80105ad9:	83 ec 34             	sub    $0x34,%esp
80105adc:	89 4d d0             	mov    %ecx,-0x30(%ebp)
80105adf:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80105ae2:	57                   	push   %edi
80105ae3:	50                   	push   %eax
{
80105ae4:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80105ae7:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80105aea:	e8 01 d2 ff ff       	call   80102cf0 <nameiparent>
80105aef:	83 c4 10             	add    $0x10,%esp
80105af2:	85 c0                	test   %eax,%eax
80105af4:	0f 84 46 01 00 00    	je     80105c40 <create+0x170>
    return 0;
  ilock(dp);
80105afa:	83 ec 0c             	sub    $0xc,%esp
80105afd:	89 c3                	mov    %eax,%ebx
80105aff:	50                   	push   %eax
80105b00:	e8 ab c8 ff ff       	call   801023b0 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80105b05:	83 c4 0c             	add    $0xc,%esp
80105b08:	6a 00                	push   $0x0
80105b0a:	57                   	push   %edi
80105b0b:	53                   	push   %ebx
80105b0c:	e8 ff cd ff ff       	call   80102910 <dirlookup>
80105b11:	83 c4 10             	add    $0x10,%esp
80105b14:	89 c6                	mov    %eax,%esi
80105b16:	85 c0                	test   %eax,%eax
80105b18:	74 56                	je     80105b70 <create+0xa0>
    iunlockput(dp);
80105b1a:	83 ec 0c             	sub    $0xc,%esp
80105b1d:	53                   	push   %ebx
80105b1e:	e8 1d cb ff ff       	call   80102640 <iunlockput>
    ilock(ip);
80105b23:	89 34 24             	mov    %esi,(%esp)
80105b26:	e8 85 c8 ff ff       	call   801023b0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80105b2b:	83 c4 10             	add    $0x10,%esp
80105b2e:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80105b33:	75 1b                	jne    80105b50 <create+0x80>
80105b35:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
80105b3a:	75 14                	jne    80105b50 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80105b3c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b3f:	89 f0                	mov    %esi,%eax
80105b41:	5b                   	pop    %ebx
80105b42:	5e                   	pop    %esi
80105b43:	5f                   	pop    %edi
80105b44:	5d                   	pop    %ebp
80105b45:	c3                   	ret    
80105b46:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b4d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
80105b50:	83 ec 0c             	sub    $0xc,%esp
80105b53:	56                   	push   %esi
    return 0;
80105b54:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
80105b56:	e8 e5 ca ff ff       	call   80102640 <iunlockput>
    return 0;
80105b5b:	83 c4 10             	add    $0x10,%esp
}
80105b5e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b61:	89 f0                	mov    %esi,%eax
80105b63:	5b                   	pop    %ebx
80105b64:	5e                   	pop    %esi
80105b65:	5f                   	pop    %edi
80105b66:	5d                   	pop    %ebp
80105b67:	c3                   	ret    
80105b68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b6f:	90                   	nop
  if((ip = ialloc(dp->dev, type)) == 0)
80105b70:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80105b74:	83 ec 08             	sub    $0x8,%esp
80105b77:	50                   	push   %eax
80105b78:	ff 33                	push   (%ebx)
80105b7a:	e8 c1 c6 ff ff       	call   80102240 <ialloc>
80105b7f:	83 c4 10             	add    $0x10,%esp
80105b82:	89 c6                	mov    %eax,%esi
80105b84:	85 c0                	test   %eax,%eax
80105b86:	0f 84 cd 00 00 00    	je     80105c59 <create+0x189>
  ilock(ip);
80105b8c:	83 ec 0c             	sub    $0xc,%esp
80105b8f:	50                   	push   %eax
80105b90:	e8 1b c8 ff ff       	call   801023b0 <ilock>
  ip->major = major;
80105b95:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80105b99:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
80105b9d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80105ba1:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80105ba5:	b8 01 00 00 00       	mov    $0x1,%eax
80105baa:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
80105bae:	89 34 24             	mov    %esi,(%esp)
80105bb1:	e8 4a c7 ff ff       	call   80102300 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80105bb6:	83 c4 10             	add    $0x10,%esp
80105bb9:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80105bbe:	74 30                	je     80105bf0 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80105bc0:	83 ec 04             	sub    $0x4,%esp
80105bc3:	ff 76 04             	push   0x4(%esi)
80105bc6:	57                   	push   %edi
80105bc7:	53                   	push   %ebx
80105bc8:	e8 43 d0 ff ff       	call   80102c10 <dirlink>
80105bcd:	83 c4 10             	add    $0x10,%esp
80105bd0:	85 c0                	test   %eax,%eax
80105bd2:	78 78                	js     80105c4c <create+0x17c>
  iunlockput(dp);
80105bd4:	83 ec 0c             	sub    $0xc,%esp
80105bd7:	53                   	push   %ebx
80105bd8:	e8 63 ca ff ff       	call   80102640 <iunlockput>
  return ip;
80105bdd:	83 c4 10             	add    $0x10,%esp
}
80105be0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105be3:	89 f0                	mov    %esi,%eax
80105be5:	5b                   	pop    %ebx
80105be6:	5e                   	pop    %esi
80105be7:	5f                   	pop    %edi
80105be8:	5d                   	pop    %ebp
80105be9:	c3                   	ret    
80105bea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80105bf0:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80105bf3:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80105bf8:	53                   	push   %ebx
80105bf9:	e8 02 c7 ff ff       	call   80102300 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80105bfe:	83 c4 0c             	add    $0xc,%esp
80105c01:	ff 76 04             	push   0x4(%esi)
80105c04:	68 a4 8b 10 80       	push   $0x80108ba4
80105c09:	56                   	push   %esi
80105c0a:	e8 01 d0 ff ff       	call   80102c10 <dirlink>
80105c0f:	83 c4 10             	add    $0x10,%esp
80105c12:	85 c0                	test   %eax,%eax
80105c14:	78 18                	js     80105c2e <create+0x15e>
80105c16:	83 ec 04             	sub    $0x4,%esp
80105c19:	ff 73 04             	push   0x4(%ebx)
80105c1c:	68 a3 8b 10 80       	push   $0x80108ba3
80105c21:	56                   	push   %esi
80105c22:	e8 e9 cf ff ff       	call   80102c10 <dirlink>
80105c27:	83 c4 10             	add    $0x10,%esp
80105c2a:	85 c0                	test   %eax,%eax
80105c2c:	79 92                	jns    80105bc0 <create+0xf0>
      panic("create dots");
80105c2e:	83 ec 0c             	sub    $0xc,%esp
80105c31:	68 97 8b 10 80       	push   $0x80108b97
80105c36:	e8 45 a7 ff ff       	call   80100380 <panic>
80105c3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105c3f:	90                   	nop
}
80105c40:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80105c43:	31 f6                	xor    %esi,%esi
}
80105c45:	5b                   	pop    %ebx
80105c46:	89 f0                	mov    %esi,%eax
80105c48:	5e                   	pop    %esi
80105c49:	5f                   	pop    %edi
80105c4a:	5d                   	pop    %ebp
80105c4b:	c3                   	ret    
    panic("create: dirlink");
80105c4c:	83 ec 0c             	sub    $0xc,%esp
80105c4f:	68 a6 8b 10 80       	push   $0x80108ba6
80105c54:	e8 27 a7 ff ff       	call   80100380 <panic>
    panic("create: ialloc");
80105c59:	83 ec 0c             	sub    $0xc,%esp
80105c5c:	68 88 8b 10 80       	push   $0x80108b88
80105c61:	e8 1a a7 ff ff       	call   80100380 <panic>
80105c66:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c6d:	8d 76 00             	lea    0x0(%esi),%esi

80105c70 <sys_dup>:
{
80105c70:	55                   	push   %ebp
80105c71:	89 e5                	mov    %esp,%ebp
80105c73:	56                   	push   %esi
80105c74:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105c75:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105c78:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80105c7b:	50                   	push   %eax
80105c7c:	6a 00                	push   $0x0
80105c7e:	e8 3d fc ff ff       	call   801058c0 <argint>
80105c83:	83 c4 10             	add    $0x10,%esp
80105c86:	85 c0                	test   %eax,%eax
80105c88:	78 36                	js     80105cc0 <sys_dup+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80105c8a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105c8e:	77 30                	ja     80105cc0 <sys_dup+0x50>
80105c90:	e8 4b e9 ff ff       	call   801045e0 <myproc>
80105c95:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105c98:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80105c9c:	85 f6                	test   %esi,%esi
80105c9e:	74 20                	je     80105cc0 <sys_dup+0x50>
  struct proc *curproc = myproc();
80105ca0:	e8 3b e9 ff ff       	call   801045e0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105ca5:	31 db                	xor    %ebx,%ebx
80105ca7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105cae:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
80105cb0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105cb4:	85 d2                	test   %edx,%edx
80105cb6:	74 18                	je     80105cd0 <sys_dup+0x60>
  for(fd = 0; fd < NOFILE; fd++){
80105cb8:	83 c3 01             	add    $0x1,%ebx
80105cbb:	83 fb 10             	cmp    $0x10,%ebx
80105cbe:	75 f0                	jne    80105cb0 <sys_dup+0x40>
}
80105cc0:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80105cc3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105cc8:	89 d8                	mov    %ebx,%eax
80105cca:	5b                   	pop    %ebx
80105ccb:	5e                   	pop    %esi
80105ccc:	5d                   	pop    %ebp
80105ccd:	c3                   	ret    
80105cce:	66 90                	xchg   %ax,%ax
  filedup(f);
80105cd0:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105cd3:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80105cd7:	56                   	push   %esi
80105cd8:	e8 f3 bd ff ff       	call   80101ad0 <filedup>
  return fd;
80105cdd:	83 c4 10             	add    $0x10,%esp
}
80105ce0:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105ce3:	89 d8                	mov    %ebx,%eax
80105ce5:	5b                   	pop    %ebx
80105ce6:	5e                   	pop    %esi
80105ce7:	5d                   	pop    %ebp
80105ce8:	c3                   	ret    
80105ce9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105cf0 <sys_read>:
{
80105cf0:	55                   	push   %ebp
80105cf1:	89 e5                	mov    %esp,%ebp
80105cf3:	56                   	push   %esi
80105cf4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105cf5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105cf8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80105cfb:	53                   	push   %ebx
80105cfc:	6a 00                	push   $0x0
80105cfe:	e8 bd fb ff ff       	call   801058c0 <argint>
80105d03:	83 c4 10             	add    $0x10,%esp
80105d06:	85 c0                	test   %eax,%eax
80105d08:	78 5e                	js     80105d68 <sys_read+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80105d0a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105d0e:	77 58                	ja     80105d68 <sys_read+0x78>
80105d10:	e8 cb e8 ff ff       	call   801045e0 <myproc>
80105d15:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105d18:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80105d1c:	85 f6                	test   %esi,%esi
80105d1e:	74 48                	je     80105d68 <sys_read+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105d20:	83 ec 08             	sub    $0x8,%esp
80105d23:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105d26:	50                   	push   %eax
80105d27:	6a 02                	push   $0x2
80105d29:	e8 92 fb ff ff       	call   801058c0 <argint>
80105d2e:	83 c4 10             	add    $0x10,%esp
80105d31:	85 c0                	test   %eax,%eax
80105d33:	78 33                	js     80105d68 <sys_read+0x78>
80105d35:	83 ec 04             	sub    $0x4,%esp
80105d38:	ff 75 f0             	push   -0x10(%ebp)
80105d3b:	53                   	push   %ebx
80105d3c:	6a 01                	push   $0x1
80105d3e:	e8 cd fb ff ff       	call   80105910 <argptr>
80105d43:	83 c4 10             	add    $0x10,%esp
80105d46:	85 c0                	test   %eax,%eax
80105d48:	78 1e                	js     80105d68 <sys_read+0x78>
  return fileread(f, p, n);
80105d4a:	83 ec 04             	sub    $0x4,%esp
80105d4d:	ff 75 f0             	push   -0x10(%ebp)
80105d50:	ff 75 f4             	push   -0xc(%ebp)
80105d53:	56                   	push   %esi
80105d54:	e8 f7 be ff ff       	call   80101c50 <fileread>
80105d59:	83 c4 10             	add    $0x10,%esp
}
80105d5c:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105d5f:	5b                   	pop    %ebx
80105d60:	5e                   	pop    %esi
80105d61:	5d                   	pop    %ebp
80105d62:	c3                   	ret    
80105d63:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105d67:	90                   	nop
    return -1;
80105d68:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d6d:	eb ed                	jmp    80105d5c <sys_read+0x6c>
80105d6f:	90                   	nop

80105d70 <sys_write>:
{
80105d70:	55                   	push   %ebp
80105d71:	89 e5                	mov    %esp,%ebp
80105d73:	56                   	push   %esi
80105d74:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105d75:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105d78:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80105d7b:	53                   	push   %ebx
80105d7c:	6a 00                	push   $0x0
80105d7e:	e8 3d fb ff ff       	call   801058c0 <argint>
80105d83:	83 c4 10             	add    $0x10,%esp
80105d86:	85 c0                	test   %eax,%eax
80105d88:	78 5e                	js     80105de8 <sys_write+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80105d8a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105d8e:	77 58                	ja     80105de8 <sys_write+0x78>
80105d90:	e8 4b e8 ff ff       	call   801045e0 <myproc>
80105d95:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105d98:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80105d9c:	85 f6                	test   %esi,%esi
80105d9e:	74 48                	je     80105de8 <sys_write+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105da0:	83 ec 08             	sub    $0x8,%esp
80105da3:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105da6:	50                   	push   %eax
80105da7:	6a 02                	push   $0x2
80105da9:	e8 12 fb ff ff       	call   801058c0 <argint>
80105dae:	83 c4 10             	add    $0x10,%esp
80105db1:	85 c0                	test   %eax,%eax
80105db3:	78 33                	js     80105de8 <sys_write+0x78>
80105db5:	83 ec 04             	sub    $0x4,%esp
80105db8:	ff 75 f0             	push   -0x10(%ebp)
80105dbb:	53                   	push   %ebx
80105dbc:	6a 01                	push   $0x1
80105dbe:	e8 4d fb ff ff       	call   80105910 <argptr>
80105dc3:	83 c4 10             	add    $0x10,%esp
80105dc6:	85 c0                	test   %eax,%eax
80105dc8:	78 1e                	js     80105de8 <sys_write+0x78>
  return filewrite(f, p, n);
80105dca:	83 ec 04             	sub    $0x4,%esp
80105dcd:	ff 75 f0             	push   -0x10(%ebp)
80105dd0:	ff 75 f4             	push   -0xc(%ebp)
80105dd3:	56                   	push   %esi
80105dd4:	e8 07 bf ff ff       	call   80101ce0 <filewrite>
80105dd9:	83 c4 10             	add    $0x10,%esp
}
80105ddc:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105ddf:	5b                   	pop    %ebx
80105de0:	5e                   	pop    %esi
80105de1:	5d                   	pop    %ebp
80105de2:	c3                   	ret    
80105de3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105de7:	90                   	nop
    return -1;
80105de8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ded:	eb ed                	jmp    80105ddc <sys_write+0x6c>
80105def:	90                   	nop

80105df0 <sys_close>:
{
80105df0:	55                   	push   %ebp
80105df1:	89 e5                	mov    %esp,%ebp
80105df3:	56                   	push   %esi
80105df4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105df5:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105df8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80105dfb:	50                   	push   %eax
80105dfc:	6a 00                	push   $0x0
80105dfe:	e8 bd fa ff ff       	call   801058c0 <argint>
80105e03:	83 c4 10             	add    $0x10,%esp
80105e06:	85 c0                	test   %eax,%eax
80105e08:	78 3e                	js     80105e48 <sys_close+0x58>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80105e0a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105e0e:	77 38                	ja     80105e48 <sys_close+0x58>
80105e10:	e8 cb e7 ff ff       	call   801045e0 <myproc>
80105e15:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105e18:	8d 5a 08             	lea    0x8(%edx),%ebx
80105e1b:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
80105e1f:	85 f6                	test   %esi,%esi
80105e21:	74 25                	je     80105e48 <sys_close+0x58>
  myproc()->ofile[fd] = 0;
80105e23:	e8 b8 e7 ff ff       	call   801045e0 <myproc>
  fileclose(f);
80105e28:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80105e2b:	c7 44 98 08 00 00 00 	movl   $0x0,0x8(%eax,%ebx,4)
80105e32:	00 
  fileclose(f);
80105e33:	56                   	push   %esi
80105e34:	e8 e7 bc ff ff       	call   80101b20 <fileclose>
  return 0;
80105e39:	83 c4 10             	add    $0x10,%esp
80105e3c:	31 c0                	xor    %eax,%eax
}
80105e3e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105e41:	5b                   	pop    %ebx
80105e42:	5e                   	pop    %esi
80105e43:	5d                   	pop    %ebp
80105e44:	c3                   	ret    
80105e45:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105e48:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e4d:	eb ef                	jmp    80105e3e <sys_close+0x4e>
80105e4f:	90                   	nop

80105e50 <sys_fstat>:
{
80105e50:	55                   	push   %ebp
80105e51:	89 e5                	mov    %esp,%ebp
80105e53:	56                   	push   %esi
80105e54:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105e55:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105e58:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80105e5b:	53                   	push   %ebx
80105e5c:	6a 00                	push   $0x0
80105e5e:	e8 5d fa ff ff       	call   801058c0 <argint>
80105e63:	83 c4 10             	add    $0x10,%esp
80105e66:	85 c0                	test   %eax,%eax
80105e68:	78 46                	js     80105eb0 <sys_fstat+0x60>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80105e6a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105e6e:	77 40                	ja     80105eb0 <sys_fstat+0x60>
80105e70:	e8 6b e7 ff ff       	call   801045e0 <myproc>
80105e75:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105e78:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80105e7c:	85 f6                	test   %esi,%esi
80105e7e:	74 30                	je     80105eb0 <sys_fstat+0x60>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105e80:	83 ec 04             	sub    $0x4,%esp
80105e83:	6a 14                	push   $0x14
80105e85:	53                   	push   %ebx
80105e86:	6a 01                	push   $0x1
80105e88:	e8 83 fa ff ff       	call   80105910 <argptr>
80105e8d:	83 c4 10             	add    $0x10,%esp
80105e90:	85 c0                	test   %eax,%eax
80105e92:	78 1c                	js     80105eb0 <sys_fstat+0x60>
  return filestat(f, st);
80105e94:	83 ec 08             	sub    $0x8,%esp
80105e97:	ff 75 f4             	push   -0xc(%ebp)
80105e9a:	56                   	push   %esi
80105e9b:	e8 60 bd ff ff       	call   80101c00 <filestat>
80105ea0:	83 c4 10             	add    $0x10,%esp
}
80105ea3:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105ea6:	5b                   	pop    %ebx
80105ea7:	5e                   	pop    %esi
80105ea8:	5d                   	pop    %ebp
80105ea9:	c3                   	ret    
80105eaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80105eb0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105eb5:	eb ec                	jmp    80105ea3 <sys_fstat+0x53>
80105eb7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105ebe:	66 90                	xchg   %ax,%ax

80105ec0 <sys_link>:
{
80105ec0:	55                   	push   %ebp
80105ec1:	89 e5                	mov    %esp,%ebp
80105ec3:	57                   	push   %edi
80105ec4:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105ec5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105ec8:	53                   	push   %ebx
80105ec9:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105ecc:	50                   	push   %eax
80105ecd:	6a 00                	push   $0x0
80105ecf:	e8 ac fa ff ff       	call   80105980 <argstr>
80105ed4:	83 c4 10             	add    $0x10,%esp
80105ed7:	85 c0                	test   %eax,%eax
80105ed9:	0f 88 fb 00 00 00    	js     80105fda <sys_link+0x11a>
80105edf:	83 ec 08             	sub    $0x8,%esp
80105ee2:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105ee5:	50                   	push   %eax
80105ee6:	6a 01                	push   $0x1
80105ee8:	e8 93 fa ff ff       	call   80105980 <argstr>
80105eed:	83 c4 10             	add    $0x10,%esp
80105ef0:	85 c0                	test   %eax,%eax
80105ef2:	0f 88 e2 00 00 00    	js     80105fda <sys_link+0x11a>
  begin_op();
80105ef8:	e8 93 da ff ff       	call   80103990 <begin_op>
  if((ip = namei(old)) == 0){
80105efd:	83 ec 0c             	sub    $0xc,%esp
80105f00:	ff 75 d4             	push   -0x2c(%ebp)
80105f03:	e8 c8 cd ff ff       	call   80102cd0 <namei>
80105f08:	83 c4 10             	add    $0x10,%esp
80105f0b:	89 c3                	mov    %eax,%ebx
80105f0d:	85 c0                	test   %eax,%eax
80105f0f:	0f 84 e4 00 00 00    	je     80105ff9 <sys_link+0x139>
  ilock(ip);
80105f15:	83 ec 0c             	sub    $0xc,%esp
80105f18:	50                   	push   %eax
80105f19:	e8 92 c4 ff ff       	call   801023b0 <ilock>
  if(ip->type == T_DIR){
80105f1e:	83 c4 10             	add    $0x10,%esp
80105f21:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105f26:	0f 84 b5 00 00 00    	je     80105fe1 <sys_link+0x121>
  iupdate(ip);
80105f2c:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
80105f2f:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80105f34:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105f37:	53                   	push   %ebx
80105f38:	e8 c3 c3 ff ff       	call   80102300 <iupdate>
  iunlock(ip);
80105f3d:	89 1c 24             	mov    %ebx,(%esp)
80105f40:	e8 4b c5 ff ff       	call   80102490 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105f45:	58                   	pop    %eax
80105f46:	5a                   	pop    %edx
80105f47:	57                   	push   %edi
80105f48:	ff 75 d0             	push   -0x30(%ebp)
80105f4b:	e8 a0 cd ff ff       	call   80102cf0 <nameiparent>
80105f50:	83 c4 10             	add    $0x10,%esp
80105f53:	89 c6                	mov    %eax,%esi
80105f55:	85 c0                	test   %eax,%eax
80105f57:	74 5b                	je     80105fb4 <sys_link+0xf4>
  ilock(dp);
80105f59:	83 ec 0c             	sub    $0xc,%esp
80105f5c:	50                   	push   %eax
80105f5d:	e8 4e c4 ff ff       	call   801023b0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105f62:	8b 03                	mov    (%ebx),%eax
80105f64:	83 c4 10             	add    $0x10,%esp
80105f67:	39 06                	cmp    %eax,(%esi)
80105f69:	75 3d                	jne    80105fa8 <sys_link+0xe8>
80105f6b:	83 ec 04             	sub    $0x4,%esp
80105f6e:	ff 73 04             	push   0x4(%ebx)
80105f71:	57                   	push   %edi
80105f72:	56                   	push   %esi
80105f73:	e8 98 cc ff ff       	call   80102c10 <dirlink>
80105f78:	83 c4 10             	add    $0x10,%esp
80105f7b:	85 c0                	test   %eax,%eax
80105f7d:	78 29                	js     80105fa8 <sys_link+0xe8>
  iunlockput(dp);
80105f7f:	83 ec 0c             	sub    $0xc,%esp
80105f82:	56                   	push   %esi
80105f83:	e8 b8 c6 ff ff       	call   80102640 <iunlockput>
  iput(ip);
80105f88:	89 1c 24             	mov    %ebx,(%esp)
80105f8b:	e8 50 c5 ff ff       	call   801024e0 <iput>
  end_op();
80105f90:	e8 6b da ff ff       	call   80103a00 <end_op>
  return 0;
80105f95:	83 c4 10             	add    $0x10,%esp
80105f98:	31 c0                	xor    %eax,%eax
}
80105f9a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105f9d:	5b                   	pop    %ebx
80105f9e:	5e                   	pop    %esi
80105f9f:	5f                   	pop    %edi
80105fa0:	5d                   	pop    %ebp
80105fa1:	c3                   	ret    
80105fa2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105fa8:	83 ec 0c             	sub    $0xc,%esp
80105fab:	56                   	push   %esi
80105fac:	e8 8f c6 ff ff       	call   80102640 <iunlockput>
    goto bad;
80105fb1:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105fb4:	83 ec 0c             	sub    $0xc,%esp
80105fb7:	53                   	push   %ebx
80105fb8:	e8 f3 c3 ff ff       	call   801023b0 <ilock>
  ip->nlink--;
80105fbd:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105fc2:	89 1c 24             	mov    %ebx,(%esp)
80105fc5:	e8 36 c3 ff ff       	call   80102300 <iupdate>
  iunlockput(ip);
80105fca:	89 1c 24             	mov    %ebx,(%esp)
80105fcd:	e8 6e c6 ff ff       	call   80102640 <iunlockput>
  end_op();
80105fd2:	e8 29 da ff ff       	call   80103a00 <end_op>
  return -1;
80105fd7:	83 c4 10             	add    $0x10,%esp
80105fda:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105fdf:	eb b9                	jmp    80105f9a <sys_link+0xda>
    iunlockput(ip);
80105fe1:	83 ec 0c             	sub    $0xc,%esp
80105fe4:	53                   	push   %ebx
80105fe5:	e8 56 c6 ff ff       	call   80102640 <iunlockput>
    end_op();
80105fea:	e8 11 da ff ff       	call   80103a00 <end_op>
    return -1;
80105fef:	83 c4 10             	add    $0x10,%esp
80105ff2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ff7:	eb a1                	jmp    80105f9a <sys_link+0xda>
    end_op();
80105ff9:	e8 02 da ff ff       	call   80103a00 <end_op>
    return -1;
80105ffe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106003:	eb 95                	jmp    80105f9a <sys_link+0xda>
80106005:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010600c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106010 <sys_unlink>:
{
80106010:	55                   	push   %ebp
80106011:	89 e5                	mov    %esp,%ebp
80106013:	57                   	push   %edi
80106014:	56                   	push   %esi
  if(argstr(0, &path) < 0)
80106015:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80106018:	53                   	push   %ebx
80106019:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
8010601c:	50                   	push   %eax
8010601d:	6a 00                	push   $0x0
8010601f:	e8 5c f9 ff ff       	call   80105980 <argstr>
80106024:	83 c4 10             	add    $0x10,%esp
80106027:	85 c0                	test   %eax,%eax
80106029:	0f 88 7a 01 00 00    	js     801061a9 <sys_unlink+0x199>
  begin_op();
8010602f:	e8 5c d9 ff ff       	call   80103990 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80106034:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80106037:	83 ec 08             	sub    $0x8,%esp
8010603a:	53                   	push   %ebx
8010603b:	ff 75 c0             	push   -0x40(%ebp)
8010603e:	e8 ad cc ff ff       	call   80102cf0 <nameiparent>
80106043:	83 c4 10             	add    $0x10,%esp
80106046:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80106049:	85 c0                	test   %eax,%eax
8010604b:	0f 84 62 01 00 00    	je     801061b3 <sys_unlink+0x1a3>
  ilock(dp);
80106051:	8b 7d b4             	mov    -0x4c(%ebp),%edi
80106054:	83 ec 0c             	sub    $0xc,%esp
80106057:	57                   	push   %edi
80106058:	e8 53 c3 ff ff       	call   801023b0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010605d:	58                   	pop    %eax
8010605e:	5a                   	pop    %edx
8010605f:	68 a4 8b 10 80       	push   $0x80108ba4
80106064:	53                   	push   %ebx
80106065:	e8 86 c8 ff ff       	call   801028f0 <namecmp>
8010606a:	83 c4 10             	add    $0x10,%esp
8010606d:	85 c0                	test   %eax,%eax
8010606f:	0f 84 fb 00 00 00    	je     80106170 <sys_unlink+0x160>
80106075:	83 ec 08             	sub    $0x8,%esp
80106078:	68 a3 8b 10 80       	push   $0x80108ba3
8010607d:	53                   	push   %ebx
8010607e:	e8 6d c8 ff ff       	call   801028f0 <namecmp>
80106083:	83 c4 10             	add    $0x10,%esp
80106086:	85 c0                	test   %eax,%eax
80106088:	0f 84 e2 00 00 00    	je     80106170 <sys_unlink+0x160>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010608e:	83 ec 04             	sub    $0x4,%esp
80106091:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80106094:	50                   	push   %eax
80106095:	53                   	push   %ebx
80106096:	57                   	push   %edi
80106097:	e8 74 c8 ff ff       	call   80102910 <dirlookup>
8010609c:	83 c4 10             	add    $0x10,%esp
8010609f:	89 c3                	mov    %eax,%ebx
801060a1:	85 c0                	test   %eax,%eax
801060a3:	0f 84 c7 00 00 00    	je     80106170 <sys_unlink+0x160>
  ilock(ip);
801060a9:	83 ec 0c             	sub    $0xc,%esp
801060ac:	50                   	push   %eax
801060ad:	e8 fe c2 ff ff       	call   801023b0 <ilock>
  if(ip->nlink < 1)
801060b2:	83 c4 10             	add    $0x10,%esp
801060b5:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801060ba:	0f 8e 1c 01 00 00    	jle    801061dc <sys_unlink+0x1cc>
  if(ip->type == T_DIR && !isdirempty(ip)){
801060c0:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801060c5:	8d 7d d8             	lea    -0x28(%ebp),%edi
801060c8:	74 66                	je     80106130 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
801060ca:	83 ec 04             	sub    $0x4,%esp
801060cd:	6a 10                	push   $0x10
801060cf:	6a 00                	push   $0x0
801060d1:	57                   	push   %edi
801060d2:	e8 d9 f4 ff ff       	call   801055b0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801060d7:	6a 10                	push   $0x10
801060d9:	ff 75 c4             	push   -0x3c(%ebp)
801060dc:	57                   	push   %edi
801060dd:	ff 75 b4             	push   -0x4c(%ebp)
801060e0:	e8 db c6 ff ff       	call   801027c0 <writei>
801060e5:	83 c4 20             	add    $0x20,%esp
801060e8:	83 f8 10             	cmp    $0x10,%eax
801060eb:	0f 85 de 00 00 00    	jne    801061cf <sys_unlink+0x1bf>
  if(ip->type == T_DIR){
801060f1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801060f6:	0f 84 94 00 00 00    	je     80106190 <sys_unlink+0x180>
  iunlockput(dp);
801060fc:	83 ec 0c             	sub    $0xc,%esp
801060ff:	ff 75 b4             	push   -0x4c(%ebp)
80106102:	e8 39 c5 ff ff       	call   80102640 <iunlockput>
  ip->nlink--;
80106107:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
8010610c:	89 1c 24             	mov    %ebx,(%esp)
8010610f:	e8 ec c1 ff ff       	call   80102300 <iupdate>
  iunlockput(ip);
80106114:	89 1c 24             	mov    %ebx,(%esp)
80106117:	e8 24 c5 ff ff       	call   80102640 <iunlockput>
  end_op();
8010611c:	e8 df d8 ff ff       	call   80103a00 <end_op>
  return 0;
80106121:	83 c4 10             	add    $0x10,%esp
80106124:	31 c0                	xor    %eax,%eax
}
80106126:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106129:	5b                   	pop    %ebx
8010612a:	5e                   	pop    %esi
8010612b:	5f                   	pop    %edi
8010612c:	5d                   	pop    %ebp
8010612d:	c3                   	ret    
8010612e:	66 90                	xchg   %ax,%ax
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80106130:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80106134:	76 94                	jbe    801060ca <sys_unlink+0xba>
80106136:	be 20 00 00 00       	mov    $0x20,%esi
8010613b:	eb 0b                	jmp    80106148 <sys_unlink+0x138>
8010613d:	8d 76 00             	lea    0x0(%esi),%esi
80106140:	83 c6 10             	add    $0x10,%esi
80106143:	3b 73 58             	cmp    0x58(%ebx),%esi
80106146:	73 82                	jae    801060ca <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80106148:	6a 10                	push   $0x10
8010614a:	56                   	push   %esi
8010614b:	57                   	push   %edi
8010614c:	53                   	push   %ebx
8010614d:	e8 6e c5 ff ff       	call   801026c0 <readi>
80106152:	83 c4 10             	add    $0x10,%esp
80106155:	83 f8 10             	cmp    $0x10,%eax
80106158:	75 68                	jne    801061c2 <sys_unlink+0x1b2>
    if(de.inum != 0)
8010615a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010615f:	74 df                	je     80106140 <sys_unlink+0x130>
    iunlockput(ip);
80106161:	83 ec 0c             	sub    $0xc,%esp
80106164:	53                   	push   %ebx
80106165:	e8 d6 c4 ff ff       	call   80102640 <iunlockput>
    goto bad;
8010616a:	83 c4 10             	add    $0x10,%esp
8010616d:	8d 76 00             	lea    0x0(%esi),%esi
  iunlockput(dp);
80106170:	83 ec 0c             	sub    $0xc,%esp
80106173:	ff 75 b4             	push   -0x4c(%ebp)
80106176:	e8 c5 c4 ff ff       	call   80102640 <iunlockput>
  end_op();
8010617b:	e8 80 d8 ff ff       	call   80103a00 <end_op>
  return -1;
80106180:	83 c4 10             	add    $0x10,%esp
80106183:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106188:	eb 9c                	jmp    80106126 <sys_unlink+0x116>
8010618a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    dp->nlink--;
80106190:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
80106193:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80106196:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
8010619b:	50                   	push   %eax
8010619c:	e8 5f c1 ff ff       	call   80102300 <iupdate>
801061a1:	83 c4 10             	add    $0x10,%esp
801061a4:	e9 53 ff ff ff       	jmp    801060fc <sys_unlink+0xec>
    return -1;
801061a9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801061ae:	e9 73 ff ff ff       	jmp    80106126 <sys_unlink+0x116>
    end_op();
801061b3:	e8 48 d8 ff ff       	call   80103a00 <end_op>
    return -1;
801061b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801061bd:	e9 64 ff ff ff       	jmp    80106126 <sys_unlink+0x116>
      panic("isdirempty: readi");
801061c2:	83 ec 0c             	sub    $0xc,%esp
801061c5:	68 c8 8b 10 80       	push   $0x80108bc8
801061ca:	e8 b1 a1 ff ff       	call   80100380 <panic>
    panic("unlink: writei");
801061cf:	83 ec 0c             	sub    $0xc,%esp
801061d2:	68 da 8b 10 80       	push   $0x80108bda
801061d7:	e8 a4 a1 ff ff       	call   80100380 <panic>
    panic("unlink: nlink < 1");
801061dc:	83 ec 0c             	sub    $0xc,%esp
801061df:	68 b6 8b 10 80       	push   $0x80108bb6
801061e4:	e8 97 a1 ff ff       	call   80100380 <panic>
801061e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801061f0 <sys_open>:

int
sys_open(void)
{
801061f0:	55                   	push   %ebp
801061f1:	89 e5                	mov    %esp,%ebp
801061f3:	57                   	push   %edi
801061f4:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801061f5:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
801061f8:	53                   	push   %ebx
801061f9:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801061fc:	50                   	push   %eax
801061fd:	6a 00                	push   $0x0
801061ff:	e8 7c f7 ff ff       	call   80105980 <argstr>
80106204:	83 c4 10             	add    $0x10,%esp
80106207:	85 c0                	test   %eax,%eax
80106209:	0f 88 8e 00 00 00    	js     8010629d <sys_open+0xad>
8010620f:	83 ec 08             	sub    $0x8,%esp
80106212:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106215:	50                   	push   %eax
80106216:	6a 01                	push   $0x1
80106218:	e8 a3 f6 ff ff       	call   801058c0 <argint>
8010621d:	83 c4 10             	add    $0x10,%esp
80106220:	85 c0                	test   %eax,%eax
80106222:	78 79                	js     8010629d <sys_open+0xad>
    return -1;

  begin_op();
80106224:	e8 67 d7 ff ff       	call   80103990 <begin_op>

  if(omode & O_CREATE){
80106229:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
8010622d:	75 79                	jne    801062a8 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
8010622f:	83 ec 0c             	sub    $0xc,%esp
80106232:	ff 75 e0             	push   -0x20(%ebp)
80106235:	e8 96 ca ff ff       	call   80102cd0 <namei>
8010623a:	83 c4 10             	add    $0x10,%esp
8010623d:	89 c6                	mov    %eax,%esi
8010623f:	85 c0                	test   %eax,%eax
80106241:	0f 84 7e 00 00 00    	je     801062c5 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
80106247:	83 ec 0c             	sub    $0xc,%esp
8010624a:	50                   	push   %eax
8010624b:	e8 60 c1 ff ff       	call   801023b0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80106250:	83 c4 10             	add    $0x10,%esp
80106253:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80106258:	0f 84 c2 00 00 00    	je     80106320 <sys_open+0x130>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
8010625e:	e8 fd b7 ff ff       	call   80101a60 <filealloc>
80106263:	89 c7                	mov    %eax,%edi
80106265:	85 c0                	test   %eax,%eax
80106267:	74 23                	je     8010628c <sys_open+0x9c>
  struct proc *curproc = myproc();
80106269:	e8 72 e3 ff ff       	call   801045e0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010626e:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
80106270:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80106274:	85 d2                	test   %edx,%edx
80106276:	74 60                	je     801062d8 <sys_open+0xe8>
  for(fd = 0; fd < NOFILE; fd++){
80106278:	83 c3 01             	add    $0x1,%ebx
8010627b:	83 fb 10             	cmp    $0x10,%ebx
8010627e:	75 f0                	jne    80106270 <sys_open+0x80>
    if(f)
      fileclose(f);
80106280:	83 ec 0c             	sub    $0xc,%esp
80106283:	57                   	push   %edi
80106284:	e8 97 b8 ff ff       	call   80101b20 <fileclose>
80106289:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010628c:	83 ec 0c             	sub    $0xc,%esp
8010628f:	56                   	push   %esi
80106290:	e8 ab c3 ff ff       	call   80102640 <iunlockput>
    end_op();
80106295:	e8 66 d7 ff ff       	call   80103a00 <end_op>
    return -1;
8010629a:	83 c4 10             	add    $0x10,%esp
8010629d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801062a2:	eb 6d                	jmp    80106311 <sys_open+0x121>
801062a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
801062a8:	83 ec 0c             	sub    $0xc,%esp
801062ab:	8b 45 e0             	mov    -0x20(%ebp),%eax
801062ae:	31 c9                	xor    %ecx,%ecx
801062b0:	ba 02 00 00 00       	mov    $0x2,%edx
801062b5:	6a 00                	push   $0x0
801062b7:	e8 14 f8 ff ff       	call   80105ad0 <create>
    if(ip == 0){
801062bc:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
801062bf:	89 c6                	mov    %eax,%esi
    if(ip == 0){
801062c1:	85 c0                	test   %eax,%eax
801062c3:	75 99                	jne    8010625e <sys_open+0x6e>
      end_op();
801062c5:	e8 36 d7 ff ff       	call   80103a00 <end_op>
      return -1;
801062ca:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801062cf:	eb 40                	jmp    80106311 <sys_open+0x121>
801062d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
801062d8:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
801062db:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
801062df:	56                   	push   %esi
801062e0:	e8 ab c1 ff ff       	call   80102490 <iunlock>
  end_op();
801062e5:	e8 16 d7 ff ff       	call   80103a00 <end_op>

  f->type = FD_INODE;
801062ea:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801062f0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801062f3:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
801062f6:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
801062f9:	89 d0                	mov    %edx,%eax
  f->off = 0;
801062fb:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80106302:	f7 d0                	not    %eax
80106304:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106307:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
8010630a:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010630d:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80106311:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106314:	89 d8                	mov    %ebx,%eax
80106316:	5b                   	pop    %ebx
80106317:	5e                   	pop    %esi
80106318:	5f                   	pop    %edi
80106319:	5d                   	pop    %ebp
8010631a:	c3                   	ret    
8010631b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010631f:	90                   	nop
    if(ip->type == T_DIR && omode != O_RDONLY){
80106320:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106323:	85 c9                	test   %ecx,%ecx
80106325:	0f 84 33 ff ff ff    	je     8010625e <sys_open+0x6e>
8010632b:	e9 5c ff ff ff       	jmp    8010628c <sys_open+0x9c>

80106330 <sys_mkdir>:

int
sys_mkdir(void)
{
80106330:	55                   	push   %ebp
80106331:	89 e5                	mov    %esp,%ebp
80106333:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80106336:	e8 55 d6 ff ff       	call   80103990 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010633b:	83 ec 08             	sub    $0x8,%esp
8010633e:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106341:	50                   	push   %eax
80106342:	6a 00                	push   $0x0
80106344:	e8 37 f6 ff ff       	call   80105980 <argstr>
80106349:	83 c4 10             	add    $0x10,%esp
8010634c:	85 c0                	test   %eax,%eax
8010634e:	78 30                	js     80106380 <sys_mkdir+0x50>
80106350:	83 ec 0c             	sub    $0xc,%esp
80106353:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106356:	31 c9                	xor    %ecx,%ecx
80106358:	ba 01 00 00 00       	mov    $0x1,%edx
8010635d:	6a 00                	push   $0x0
8010635f:	e8 6c f7 ff ff       	call   80105ad0 <create>
80106364:	83 c4 10             	add    $0x10,%esp
80106367:	85 c0                	test   %eax,%eax
80106369:	74 15                	je     80106380 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010636b:	83 ec 0c             	sub    $0xc,%esp
8010636e:	50                   	push   %eax
8010636f:	e8 cc c2 ff ff       	call   80102640 <iunlockput>
  end_op();
80106374:	e8 87 d6 ff ff       	call   80103a00 <end_op>
  return 0;
80106379:	83 c4 10             	add    $0x10,%esp
8010637c:	31 c0                	xor    %eax,%eax
}
8010637e:	c9                   	leave  
8010637f:	c3                   	ret    
    end_op();
80106380:	e8 7b d6 ff ff       	call   80103a00 <end_op>
    return -1;
80106385:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010638a:	c9                   	leave  
8010638b:	c3                   	ret    
8010638c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106390 <sys_mknod>:

int
sys_mknod(void)
{
80106390:	55                   	push   %ebp
80106391:	89 e5                	mov    %esp,%ebp
80106393:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80106396:	e8 f5 d5 ff ff       	call   80103990 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010639b:	83 ec 08             	sub    $0x8,%esp
8010639e:	8d 45 ec             	lea    -0x14(%ebp),%eax
801063a1:	50                   	push   %eax
801063a2:	6a 00                	push   $0x0
801063a4:	e8 d7 f5 ff ff       	call   80105980 <argstr>
801063a9:	83 c4 10             	add    $0x10,%esp
801063ac:	85 c0                	test   %eax,%eax
801063ae:	78 60                	js     80106410 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
801063b0:	83 ec 08             	sub    $0x8,%esp
801063b3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801063b6:	50                   	push   %eax
801063b7:	6a 01                	push   $0x1
801063b9:	e8 02 f5 ff ff       	call   801058c0 <argint>
  if((argstr(0, &path)) < 0 ||
801063be:	83 c4 10             	add    $0x10,%esp
801063c1:	85 c0                	test   %eax,%eax
801063c3:	78 4b                	js     80106410 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
801063c5:	83 ec 08             	sub    $0x8,%esp
801063c8:	8d 45 f4             	lea    -0xc(%ebp),%eax
801063cb:	50                   	push   %eax
801063cc:	6a 02                	push   $0x2
801063ce:	e8 ed f4 ff ff       	call   801058c0 <argint>
     argint(1, &major) < 0 ||
801063d3:	83 c4 10             	add    $0x10,%esp
801063d6:	85 c0                	test   %eax,%eax
801063d8:	78 36                	js     80106410 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
801063da:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
801063de:	83 ec 0c             	sub    $0xc,%esp
801063e1:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
801063e5:	ba 03 00 00 00       	mov    $0x3,%edx
801063ea:	50                   	push   %eax
801063eb:	8b 45 ec             	mov    -0x14(%ebp),%eax
801063ee:	e8 dd f6 ff ff       	call   80105ad0 <create>
     argint(2, &minor) < 0 ||
801063f3:	83 c4 10             	add    $0x10,%esp
801063f6:	85 c0                	test   %eax,%eax
801063f8:	74 16                	je     80106410 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
801063fa:	83 ec 0c             	sub    $0xc,%esp
801063fd:	50                   	push   %eax
801063fe:	e8 3d c2 ff ff       	call   80102640 <iunlockput>
  end_op();
80106403:	e8 f8 d5 ff ff       	call   80103a00 <end_op>
  return 0;
80106408:	83 c4 10             	add    $0x10,%esp
8010640b:	31 c0                	xor    %eax,%eax
}
8010640d:	c9                   	leave  
8010640e:	c3                   	ret    
8010640f:	90                   	nop
    end_op();
80106410:	e8 eb d5 ff ff       	call   80103a00 <end_op>
    return -1;
80106415:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010641a:	c9                   	leave  
8010641b:	c3                   	ret    
8010641c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106420 <sys_chdir>:

int
sys_chdir(void)
{
80106420:	55                   	push   %ebp
80106421:	89 e5                	mov    %esp,%ebp
80106423:	56                   	push   %esi
80106424:	53                   	push   %ebx
80106425:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80106428:	e8 b3 e1 ff ff       	call   801045e0 <myproc>
8010642d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010642f:	e8 5c d5 ff ff       	call   80103990 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80106434:	83 ec 08             	sub    $0x8,%esp
80106437:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010643a:	50                   	push   %eax
8010643b:	6a 00                	push   $0x0
8010643d:	e8 3e f5 ff ff       	call   80105980 <argstr>
80106442:	83 c4 10             	add    $0x10,%esp
80106445:	85 c0                	test   %eax,%eax
80106447:	78 77                	js     801064c0 <sys_chdir+0xa0>
80106449:	83 ec 0c             	sub    $0xc,%esp
8010644c:	ff 75 f4             	push   -0xc(%ebp)
8010644f:	e8 7c c8 ff ff       	call   80102cd0 <namei>
80106454:	83 c4 10             	add    $0x10,%esp
80106457:	89 c3                	mov    %eax,%ebx
80106459:	85 c0                	test   %eax,%eax
8010645b:	74 63                	je     801064c0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010645d:	83 ec 0c             	sub    $0xc,%esp
80106460:	50                   	push   %eax
80106461:	e8 4a bf ff ff       	call   801023b0 <ilock>
  if(ip->type != T_DIR){
80106466:	83 c4 10             	add    $0x10,%esp
80106469:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010646e:	75 30                	jne    801064a0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80106470:	83 ec 0c             	sub    $0xc,%esp
80106473:	53                   	push   %ebx
80106474:	e8 17 c0 ff ff       	call   80102490 <iunlock>
  iput(curproc->cwd);
80106479:	58                   	pop    %eax
8010647a:	ff 76 68             	push   0x68(%esi)
8010647d:	e8 5e c0 ff ff       	call   801024e0 <iput>
  end_op();
80106482:	e8 79 d5 ff ff       	call   80103a00 <end_op>
  curproc->cwd = ip;
80106487:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010648a:	83 c4 10             	add    $0x10,%esp
8010648d:	31 c0                	xor    %eax,%eax
}
8010648f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106492:	5b                   	pop    %ebx
80106493:	5e                   	pop    %esi
80106494:	5d                   	pop    %ebp
80106495:	c3                   	ret    
80106496:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010649d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
801064a0:	83 ec 0c             	sub    $0xc,%esp
801064a3:	53                   	push   %ebx
801064a4:	e8 97 c1 ff ff       	call   80102640 <iunlockput>
    end_op();
801064a9:	e8 52 d5 ff ff       	call   80103a00 <end_op>
    return -1;
801064ae:	83 c4 10             	add    $0x10,%esp
801064b1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801064b6:	eb d7                	jmp    8010648f <sys_chdir+0x6f>
801064b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801064bf:	90                   	nop
    end_op();
801064c0:	e8 3b d5 ff ff       	call   80103a00 <end_op>
    return -1;
801064c5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801064ca:	eb c3                	jmp    8010648f <sys_chdir+0x6f>
801064cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801064d0 <sys_exec>:

int
sys_exec(void)
{
801064d0:	55                   	push   %ebp
801064d1:	89 e5                	mov    %esp,%ebp
801064d3:	57                   	push   %edi
801064d4:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801064d5:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
801064db:	53                   	push   %ebx
801064dc:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801064e2:	50                   	push   %eax
801064e3:	6a 00                	push   $0x0
801064e5:	e8 96 f4 ff ff       	call   80105980 <argstr>
801064ea:	83 c4 10             	add    $0x10,%esp
801064ed:	85 c0                	test   %eax,%eax
801064ef:	0f 88 87 00 00 00    	js     8010657c <sys_exec+0xac>
801064f5:	83 ec 08             	sub    $0x8,%esp
801064f8:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801064fe:	50                   	push   %eax
801064ff:	6a 01                	push   $0x1
80106501:	e8 ba f3 ff ff       	call   801058c0 <argint>
80106506:	83 c4 10             	add    $0x10,%esp
80106509:	85 c0                	test   %eax,%eax
8010650b:	78 6f                	js     8010657c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010650d:	83 ec 04             	sub    $0x4,%esp
80106510:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
  for(i=0;; i++){
80106516:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80106518:	68 80 00 00 00       	push   $0x80
8010651d:	6a 00                	push   $0x0
8010651f:	56                   	push   %esi
80106520:	e8 8b f0 ff ff       	call   801055b0 <memset>
80106525:	83 c4 10             	add    $0x10,%esp
80106528:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010652f:	90                   	nop
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80106530:	83 ec 08             	sub    $0x8,%esp
80106533:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
80106539:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
80106540:	50                   	push   %eax
80106541:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80106547:	01 f8                	add    %edi,%eax
80106549:	50                   	push   %eax
8010654a:	e8 e1 f2 ff ff       	call   80105830 <fetchint>
8010654f:	83 c4 10             	add    $0x10,%esp
80106552:	85 c0                	test   %eax,%eax
80106554:	78 26                	js     8010657c <sys_exec+0xac>
      return -1;
    if(uarg == 0){
80106556:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010655c:	85 c0                	test   %eax,%eax
8010655e:	74 30                	je     80106590 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80106560:	83 ec 08             	sub    $0x8,%esp
80106563:	8d 14 3e             	lea    (%esi,%edi,1),%edx
80106566:	52                   	push   %edx
80106567:	50                   	push   %eax
80106568:	e8 03 f3 ff ff       	call   80105870 <fetchstr>
8010656d:	83 c4 10             	add    $0x10,%esp
80106570:	85 c0                	test   %eax,%eax
80106572:	78 08                	js     8010657c <sys_exec+0xac>
  for(i=0;; i++){
80106574:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80106577:	83 fb 20             	cmp    $0x20,%ebx
8010657a:	75 b4                	jne    80106530 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010657c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010657f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106584:	5b                   	pop    %ebx
80106585:	5e                   	pop    %esi
80106586:	5f                   	pop    %edi
80106587:	5d                   	pop    %ebp
80106588:	c3                   	ret    
80106589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
80106590:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80106597:	00 00 00 00 
  return exec(path, argv);
8010659b:	83 ec 08             	sub    $0x8,%esp
8010659e:	56                   	push   %esi
8010659f:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
801065a5:	e8 36 b1 ff ff       	call   801016e0 <exec>
801065aa:	83 c4 10             	add    $0x10,%esp
}
801065ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
801065b0:	5b                   	pop    %ebx
801065b1:	5e                   	pop    %esi
801065b2:	5f                   	pop    %edi
801065b3:	5d                   	pop    %ebp
801065b4:	c3                   	ret    
801065b5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801065bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801065c0 <sys_pipe>:

int
sys_pipe(void)
{
801065c0:	55                   	push   %ebp
801065c1:	89 e5                	mov    %esp,%ebp
801065c3:	57                   	push   %edi
801065c4:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801065c5:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
801065c8:	53                   	push   %ebx
801065c9:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801065cc:	6a 08                	push   $0x8
801065ce:	50                   	push   %eax
801065cf:	6a 00                	push   $0x0
801065d1:	e8 3a f3 ff ff       	call   80105910 <argptr>
801065d6:	83 c4 10             	add    $0x10,%esp
801065d9:	85 c0                	test   %eax,%eax
801065db:	78 4a                	js     80106627 <sys_pipe+0x67>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
801065dd:	83 ec 08             	sub    $0x8,%esp
801065e0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801065e3:	50                   	push   %eax
801065e4:	8d 45 e0             	lea    -0x20(%ebp),%eax
801065e7:	50                   	push   %eax
801065e8:	e8 73 da ff ff       	call   80104060 <pipealloc>
801065ed:	83 c4 10             	add    $0x10,%esp
801065f0:	85 c0                	test   %eax,%eax
801065f2:	78 33                	js     80106627 <sys_pipe+0x67>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801065f4:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
801065f7:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
801065f9:	e8 e2 df ff ff       	call   801045e0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801065fe:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
80106600:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80106604:	85 f6                	test   %esi,%esi
80106606:	74 28                	je     80106630 <sys_pipe+0x70>
  for(fd = 0; fd < NOFILE; fd++){
80106608:	83 c3 01             	add    $0x1,%ebx
8010660b:	83 fb 10             	cmp    $0x10,%ebx
8010660e:	75 f0                	jne    80106600 <sys_pipe+0x40>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
80106610:	83 ec 0c             	sub    $0xc,%esp
80106613:	ff 75 e0             	push   -0x20(%ebp)
80106616:	e8 05 b5 ff ff       	call   80101b20 <fileclose>
    fileclose(wf);
8010661b:	58                   	pop    %eax
8010661c:	ff 75 e4             	push   -0x1c(%ebp)
8010661f:	e8 fc b4 ff ff       	call   80101b20 <fileclose>
    return -1;
80106624:	83 c4 10             	add    $0x10,%esp
80106627:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010662c:	eb 53                	jmp    80106681 <sys_pipe+0xc1>
8010662e:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80106630:	8d 73 08             	lea    0x8(%ebx),%esi
80106633:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106637:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
8010663a:	e8 a1 df ff ff       	call   801045e0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010663f:	31 d2                	xor    %edx,%edx
80106641:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80106648:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
8010664c:	85 c9                	test   %ecx,%ecx
8010664e:	74 20                	je     80106670 <sys_pipe+0xb0>
  for(fd = 0; fd < NOFILE; fd++){
80106650:	83 c2 01             	add    $0x1,%edx
80106653:	83 fa 10             	cmp    $0x10,%edx
80106656:	75 f0                	jne    80106648 <sys_pipe+0x88>
      myproc()->ofile[fd0] = 0;
80106658:	e8 83 df ff ff       	call   801045e0 <myproc>
8010665d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80106664:	00 
80106665:	eb a9                	jmp    80106610 <sys_pipe+0x50>
80106667:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010666e:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80106670:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
80106674:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106677:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80106679:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010667c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
8010667f:	31 c0                	xor    %eax,%eax
}
80106681:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106684:	5b                   	pop    %ebx
80106685:	5e                   	pop    %esi
80106686:	5f                   	pop    %edi
80106687:	5d                   	pop    %ebp
80106688:	c3                   	ret    
80106689:	66 90                	xchg   %ax,%ax
8010668b:	66 90                	xchg   %ax,%ax
8010668d:	66 90                	xchg   %ax,%ax
8010668f:	90                   	nop

80106690 <sys_fork>:
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80106690:	e9 fb e0 ff ff       	jmp    80104790 <fork>
80106695:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010669c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801066a0 <sys_exit>:
}

int
sys_exit(void)
{
801066a0:	55                   	push   %ebp
801066a1:	89 e5                	mov    %esp,%ebp
801066a3:	83 ec 08             	sub    $0x8,%esp
  exit();
801066a6:	e8 75 e3 ff ff       	call   80104a20 <exit>
  return 0;  // not reached
}
801066ab:	31 c0                	xor    %eax,%eax
801066ad:	c9                   	leave  
801066ae:	c3                   	ret    
801066af:	90                   	nop

801066b0 <sys_wait>:

int
sys_wait(void)
{
  return wait();
801066b0:	e9 9b e4 ff ff       	jmp    80104b50 <wait>
801066b5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801066bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801066c0 <sys_wait2>:
}

int sys_wait2(void)
{
801066c0:	55                   	push   %ebp
801066c1:	89 e5                	mov    %esp,%ebp
801066c3:	83 ec 1c             	sub    $0x1c,%esp
  int *stime;
  int *retime;
  int *rutime;
  if (argptr(0, (void *)&retime, sizeof(retime)) < 0)
801066c6:	8d 45 f0             	lea    -0x10(%ebp),%eax
801066c9:	6a 04                	push   $0x4
801066cb:	50                   	push   %eax
801066cc:	6a 00                	push   $0x0
801066ce:	e8 3d f2 ff ff       	call   80105910 <argptr>
801066d3:	83 c4 10             	add    $0x10,%esp
801066d6:	85 c0                	test   %eax,%eax
801066d8:	78 46                	js     80106720 <sys_wait2+0x60>
    return -1;
  if (argptr(1, (void *)&rutime, sizeof(rutime)) < 0)
801066da:	83 ec 04             	sub    $0x4,%esp
801066dd:	8d 45 f4             	lea    -0xc(%ebp),%eax
801066e0:	6a 04                	push   $0x4
801066e2:	50                   	push   %eax
801066e3:	6a 01                	push   $0x1
801066e5:	e8 26 f2 ff ff       	call   80105910 <argptr>
801066ea:	83 c4 10             	add    $0x10,%esp
801066ed:	85 c0                	test   %eax,%eax
801066ef:	78 2f                	js     80106720 <sys_wait2+0x60>
    return -1;
  if (argptr(2, (void *)&stime, sizeof(stime)) < 0)
801066f1:	83 ec 04             	sub    $0x4,%esp
801066f4:	8d 45 ec             	lea    -0x14(%ebp),%eax
801066f7:	6a 04                	push   $0x4
801066f9:	50                   	push   %eax
801066fa:	6a 02                	push   $0x2
801066fc:	e8 0f f2 ff ff       	call   80105910 <argptr>
80106701:	83 c4 10             	add    $0x10,%esp
80106704:	85 c0                	test   %eax,%eax
80106706:	78 18                	js     80106720 <sys_wait2+0x60>
    return -1;
  return wait2(retime, rutime, stime);
80106708:	83 ec 04             	sub    $0x4,%esp
8010670b:	ff 75 ec             	push   -0x14(%ebp)
8010670e:	ff 75 f4             	push   -0xc(%ebp)
80106711:	ff 75 f0             	push   -0x10(%ebp)
80106714:	e8 67 e5 ff ff       	call   80104c80 <wait2>
80106719:	83 c4 10             	add    $0x10,%esp
}
8010671c:	c9                   	leave  
8010671d:	c3                   	ret    
8010671e:	66 90                	xchg   %ax,%ax
80106720:	c9                   	leave  
    return -1;
80106721:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106726:	c3                   	ret    
80106727:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010672e:	66 90                	xchg   %ax,%ax

80106730 <sys_kill>:
int
sys_kill(void)
{
80106730:	55                   	push   %ebp
80106731:	89 e5                	mov    %esp,%ebp
80106733:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80106736:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106739:	50                   	push   %eax
8010673a:	6a 00                	push   $0x0
8010673c:	e8 7f f1 ff ff       	call   801058c0 <argint>
80106741:	83 c4 10             	add    $0x10,%esp
80106744:	85 c0                	test   %eax,%eax
80106746:	78 18                	js     80106760 <sys_kill+0x30>
    return -1;
  return kill(pid);
80106748:	83 ec 0c             	sub    $0xc,%esp
8010674b:	ff 75 f4             	push   -0xc(%ebp)
8010674e:	e8 1d e8 ff ff       	call   80104f70 <kill>
80106753:	83 c4 10             	add    $0x10,%esp
}
80106756:	c9                   	leave  
80106757:	c3                   	ret    
80106758:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010675f:	90                   	nop
80106760:	c9                   	leave  
    return -1;
80106761:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106766:	c3                   	ret    
80106767:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010676e:	66 90                	xchg   %ax,%ax

80106770 <sys_getpid>:

int
sys_getpid(void)
{
80106770:	55                   	push   %ebp
80106771:	89 e5                	mov    %esp,%ebp
80106773:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80106776:	e8 65 de ff ff       	call   801045e0 <myproc>
8010677b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010677e:	c9                   	leave  
8010677f:	c3                   	ret    

80106780 <sys_sbrk>:

int
sys_sbrk(void)
{
80106780:	55                   	push   %ebp
80106781:	89 e5                	mov    %esp,%ebp
80106783:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80106784:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80106787:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010678a:	50                   	push   %eax
8010678b:	6a 00                	push   $0x0
8010678d:	e8 2e f1 ff ff       	call   801058c0 <argint>
80106792:	83 c4 10             	add    $0x10,%esp
80106795:	85 c0                	test   %eax,%eax
80106797:	78 27                	js     801067c0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80106799:	e8 42 de ff ff       	call   801045e0 <myproc>
  if(growproc(n) < 0)
8010679e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
801067a1:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
801067a3:	ff 75 f4             	push   -0xc(%ebp)
801067a6:	e8 65 df ff ff       	call   80104710 <growproc>
801067ab:	83 c4 10             	add    $0x10,%esp
801067ae:	85 c0                	test   %eax,%eax
801067b0:	78 0e                	js     801067c0 <sys_sbrk+0x40>
    return -1;
  return addr;
}
801067b2:	89 d8                	mov    %ebx,%eax
801067b4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801067b7:	c9                   	leave  
801067b8:	c3                   	ret    
801067b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801067c0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801067c5:	eb eb                	jmp    801067b2 <sys_sbrk+0x32>
801067c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801067ce:	66 90                	xchg   %ax,%ax

801067d0 <sys_sleep>:

int
sys_sleep(void)
{
801067d0:	55                   	push   %ebp
801067d1:	89 e5                	mov    %esp,%ebp
801067d3:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801067d4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801067d7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801067da:	50                   	push   %eax
801067db:	6a 00                	push   $0x0
801067dd:	e8 de f0 ff ff       	call   801058c0 <argint>
801067e2:	83 c4 10             	add    $0x10,%esp
801067e5:	85 c0                	test   %eax,%eax
801067e7:	0f 88 8a 00 00 00    	js     80106877 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
801067ed:	83 ec 0c             	sub    $0xc,%esp
801067f0:	68 80 5d 11 80       	push   $0x80115d80
801067f5:	e8 f6 ec ff ff       	call   801054f0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801067fa:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
801067fd:	8b 1d 60 5d 11 80    	mov    0x80115d60,%ebx
  while(ticks - ticks0 < n){
80106803:	83 c4 10             	add    $0x10,%esp
80106806:	85 d2                	test   %edx,%edx
80106808:	75 27                	jne    80106831 <sys_sleep+0x61>
8010680a:	eb 54                	jmp    80106860 <sys_sleep+0x90>
8010680c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80106810:	83 ec 08             	sub    $0x8,%esp
80106813:	68 80 5d 11 80       	push   $0x80115d80
80106818:	68 60 5d 11 80       	push   $0x80115d60
8010681d:	e8 2e e6 ff ff       	call   80104e50 <sleep>
  while(ticks - ticks0 < n){
80106822:	a1 60 5d 11 80       	mov    0x80115d60,%eax
80106827:	83 c4 10             	add    $0x10,%esp
8010682a:	29 d8                	sub    %ebx,%eax
8010682c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010682f:	73 2f                	jae    80106860 <sys_sleep+0x90>
    if(myproc()->killed){
80106831:	e8 aa dd ff ff       	call   801045e0 <myproc>
80106836:	8b 40 24             	mov    0x24(%eax),%eax
80106839:	85 c0                	test   %eax,%eax
8010683b:	74 d3                	je     80106810 <sys_sleep+0x40>
      release(&tickslock);
8010683d:	83 ec 0c             	sub    $0xc,%esp
80106840:	68 80 5d 11 80       	push   $0x80115d80
80106845:	e8 46 ec ff ff       	call   80105490 <release>
  }
  release(&tickslock);
  return 0;
}
8010684a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return -1;
8010684d:	83 c4 10             	add    $0x10,%esp
80106850:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106855:	c9                   	leave  
80106856:	c3                   	ret    
80106857:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010685e:	66 90                	xchg   %ax,%ax
  release(&tickslock);
80106860:	83 ec 0c             	sub    $0xc,%esp
80106863:	68 80 5d 11 80       	push   $0x80115d80
80106868:	e8 23 ec ff ff       	call   80105490 <release>
  return 0;
8010686d:	83 c4 10             	add    $0x10,%esp
80106870:	31 c0                	xor    %eax,%eax
}
80106872:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106875:	c9                   	leave  
80106876:	c3                   	ret    
    return -1;
80106877:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010687c:	eb f4                	jmp    80106872 <sys_sleep+0xa2>
8010687e:	66 90                	xchg   %ax,%ax

80106880 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106880:	55                   	push   %ebp
80106881:	89 e5                	mov    %esp,%ebp
80106883:	53                   	push   %ebx
80106884:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80106887:	68 80 5d 11 80       	push   $0x80115d80
8010688c:	e8 5f ec ff ff       	call   801054f0 <acquire>
  xticks = ticks;
80106891:	8b 1d 60 5d 11 80    	mov    0x80115d60,%ebx
  release(&tickslock);
80106897:	c7 04 24 80 5d 11 80 	movl   $0x80115d80,(%esp)
8010689e:	e8 ed eb ff ff       	call   80105490 <release>
  return xticks;
}
801068a3:	89 d8                	mov    %ebx,%eax
801068a5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801068a8:	c9                   	leave  
801068a9:	c3                   	ret    
801068aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801068b0 <sys_ps>:

/*Q2 Changes made to return ps function */
int 
sys_ps(void){
return ps();
801068b0:	e9 fb e7 ff ff       	jmp    801050b0 <ps>
801068b5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801068bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801068c0 <sys_history>:
}

/*Q3 chnages made to return AccessHistory function*/

int 
sys_history(void){
801068c0:	55                   	push   %ebp
801068c1:	89 e5                	mov    %esp,%ebp
801068c3:	83 ec 1c             	sub    $0x1c,%esp
char * buffer; 
int hisID;
argptr(0, &buffer, 1);
801068c6:	8d 45 f0             	lea    -0x10(%ebp),%eax
801068c9:	6a 01                	push   $0x1
801068cb:	50                   	push   %eax
801068cc:	6a 00                	push   $0x0
801068ce:	e8 3d f0 ff ff       	call   80105910 <argptr>
argint(1, &hisID);
801068d3:	58                   	pop    %eax
801068d4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801068d7:	5a                   	pop    %edx
801068d8:	50                   	push   %eax
801068d9:	6a 01                	push   $0x1
801068db:	e8 e0 ef ff ff       	call   801058c0 <argint>
return AccessHistory(buffer, hisID);
801068e0:	59                   	pop    %ecx
801068e1:	58                   	pop    %eax
801068e2:	ff 75 f4             	push   -0xc(%ebp)
801068e5:	ff 75 f0             	push   -0x10(%ebp)
801068e8:	e8 13 ad ff ff       	call   80101600 <AccessHistory>

}
801068ed:	c9                   	leave  
801068ee:	c3                   	ret    

801068ef <alltraps>:
801068ef:	1e                   	push   %ds
801068f0:	06                   	push   %es
801068f1:	0f a0                	push   %fs
801068f3:	0f a8                	push   %gs
801068f5:	60                   	pusha  
801068f6:	66 b8 10 00          	mov    $0x10,%ax
801068fa:	8e d8                	mov    %eax,%ds
801068fc:	8e c0                	mov    %eax,%es
801068fe:	54                   	push   %esp
801068ff:	e8 cc 00 00 00       	call   801069d0 <trap>
80106904:	83 c4 04             	add    $0x4,%esp

80106907 <trapret>:
80106907:	61                   	popa   
80106908:	0f a9                	pop    %gs
8010690a:	0f a1                	pop    %fs
8010690c:	07                   	pop    %es
8010690d:	1f                   	pop    %ds
8010690e:	83 c4 08             	add    $0x8,%esp
80106911:	cf                   	iret   
80106912:	66 90                	xchg   %ax,%ax
80106914:	66 90                	xchg   %ax,%ax
80106916:	66 90                	xchg   %ax,%ax
80106918:	66 90                	xchg   %ax,%ax
8010691a:	66 90                	xchg   %ax,%ax
8010691c:	66 90                	xchg   %ax,%ax
8010691e:	66 90                	xchg   %ax,%ax

80106920 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106920:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80106921:	31 c0                	xor    %eax,%eax
{
80106923:	89 e5                	mov    %esp,%ebp
80106925:	83 ec 08             	sub    $0x8,%esp
80106928:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010692f:	90                   	nop
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106930:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
80106937:	c7 04 c5 c2 5d 11 80 	movl   $0x8e000008,-0x7feea23e(,%eax,8)
8010693e:	08 00 00 8e 
80106942:	66 89 14 c5 c0 5d 11 	mov    %dx,-0x7feea240(,%eax,8)
80106949:	80 
8010694a:	c1 ea 10             	shr    $0x10,%edx
8010694d:	66 89 14 c5 c6 5d 11 	mov    %dx,-0x7feea23a(,%eax,8)
80106954:	80 
  for(i = 0; i < 256; i++)
80106955:	83 c0 01             	add    $0x1,%eax
80106958:	3d 00 01 00 00       	cmp    $0x100,%eax
8010695d:	75 d1                	jne    80106930 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
8010695f:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106962:	a1 08 b1 10 80       	mov    0x8010b108,%eax
80106967:	c7 05 c2 5f 11 80 08 	movl   $0xef000008,0x80115fc2
8010696e:	00 00 ef 
  initlock(&tickslock, "time");
80106971:	68 62 8a 10 80       	push   $0x80108a62
80106976:	68 80 5d 11 80       	push   $0x80115d80
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010697b:	66 a3 c0 5f 11 80    	mov    %ax,0x80115fc0
80106981:	c1 e8 10             	shr    $0x10,%eax
80106984:	66 a3 c6 5f 11 80    	mov    %ax,0x80115fc6
  initlock(&tickslock, "time");
8010698a:	e8 91 e9 ff ff       	call   80105320 <initlock>
}
8010698f:	83 c4 10             	add    $0x10,%esp
80106992:	c9                   	leave  
80106993:	c3                   	ret    
80106994:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010699b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010699f:	90                   	nop

801069a0 <idtinit>:

void
idtinit(void)
{
801069a0:	55                   	push   %ebp
  pd[0] = size-1;
801069a1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
801069a6:	89 e5                	mov    %esp,%ebp
801069a8:	83 ec 10             	sub    $0x10,%esp
801069ab:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801069af:	b8 c0 5d 11 80       	mov    $0x80115dc0,%eax
801069b4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801069b8:	c1 e8 10             	shr    $0x10,%eax
801069bb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
801069bf:	8d 45 fa             	lea    -0x6(%ebp),%eax
801069c2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
801069c5:	c9                   	leave  
801069c6:	c3                   	ret    
801069c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801069ce:	66 90                	xchg   %ax,%ax

801069d0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801069d0:	55                   	push   %ebp
801069d1:	89 e5                	mov    %esp,%ebp
801069d3:	57                   	push   %edi
801069d4:	56                   	push   %esi
801069d5:	53                   	push   %ebx
801069d6:	83 ec 1c             	sub    $0x1c,%esp
801069d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
801069dc:	8b 43 30             	mov    0x30(%ebx),%eax
801069df:	83 f8 40             	cmp    $0x40,%eax
801069e2:	0f 84 68 01 00 00    	je     80106b50 <trap+0x180>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
801069e8:	83 e8 20             	sub    $0x20,%eax
801069eb:	83 f8 1f             	cmp    $0x1f,%eax
801069ee:	0f 87 8c 00 00 00    	ja     80106a80 <trap+0xb0>
801069f4:	ff 24 85 8c 8c 10 80 	jmp    *-0x7fef7374(,%eax,4)
801069fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801069ff:	90                   	nop
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80106a00:	e8 6b c4 ff ff       	call   80102e70 <ideintr>
    lapiceoi();
80106a05:	e8 36 cb ff ff       	call   80103540 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106a0a:	e8 d1 db ff ff       	call   801045e0 <myproc>
80106a0f:	85 c0                	test   %eax,%eax
80106a11:	74 1d                	je     80106a30 <trap+0x60>
80106a13:	e8 c8 db ff ff       	call   801045e0 <myproc>
80106a18:	8b 50 24             	mov    0x24(%eax),%edx
80106a1b:	85 d2                	test   %edx,%edx
80106a1d:	74 11                	je     80106a30 <trap+0x60>
80106a1f:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106a23:	83 e0 03             	and    $0x3,%eax
80106a26:	66 83 f8 03          	cmp    $0x3,%ax
80106a2a:	0f 84 f0 01 00 00    	je     80106c20 <trap+0x250>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80106a30:	e8 ab db ff ff       	call   801045e0 <myproc>
80106a35:	85 c0                	test   %eax,%eax
80106a37:	74 0f                	je     80106a48 <trap+0x78>
80106a39:	e8 a2 db ff ff       	call   801045e0 <myproc>
80106a3e:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80106a42:	0f 84 b8 00 00 00    	je     80106b00 <trap+0x130>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106a48:	e8 93 db ff ff       	call   801045e0 <myproc>
80106a4d:	85 c0                	test   %eax,%eax
80106a4f:	74 1d                	je     80106a6e <trap+0x9e>
80106a51:	e8 8a db ff ff       	call   801045e0 <myproc>
80106a56:	8b 40 24             	mov    0x24(%eax),%eax
80106a59:	85 c0                	test   %eax,%eax
80106a5b:	74 11                	je     80106a6e <trap+0x9e>
80106a5d:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106a61:	83 e0 03             	and    $0x3,%eax
80106a64:	66 83 f8 03          	cmp    $0x3,%ax
80106a68:	0f 84 0f 01 00 00    	je     80106b7d <trap+0x1ad>
    exit();
}
80106a6e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106a71:	5b                   	pop    %ebx
80106a72:	5e                   	pop    %esi
80106a73:	5f                   	pop    %edi
80106a74:	5d                   	pop    %ebp
80106a75:	c3                   	ret    
80106a76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a7d:	8d 76 00             	lea    0x0(%esi),%esi
    if(myproc() == 0 || (tf->cs&3) == 0){
80106a80:	e8 5b db ff ff       	call   801045e0 <myproc>
80106a85:	8b 7b 38             	mov    0x38(%ebx),%edi
80106a88:	85 c0                	test   %eax,%eax
80106a8a:	0f 84 aa 01 00 00    	je     80106c3a <trap+0x26a>
80106a90:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80106a94:	0f 84 a0 01 00 00    	je     80106c3a <trap+0x26a>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80106a9a:	0f 20 d1             	mov    %cr2,%ecx
80106a9d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106aa0:	e8 1b db ff ff       	call   801045c0 <cpuid>
80106aa5:	8b 73 30             	mov    0x30(%ebx),%esi
80106aa8:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106aab:	8b 43 34             	mov    0x34(%ebx),%eax
80106aae:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
80106ab1:	e8 2a db ff ff       	call   801045e0 <myproc>
80106ab6:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106ab9:	e8 22 db ff ff       	call   801045e0 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106abe:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80106ac1:	8b 55 dc             	mov    -0x24(%ebp),%edx
80106ac4:	51                   	push   %ecx
80106ac5:	57                   	push   %edi
80106ac6:	52                   	push   %edx
80106ac7:	ff 75 e4             	push   -0x1c(%ebp)
80106aca:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80106acb:	8b 75 e0             	mov    -0x20(%ebp),%esi
80106ace:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106ad1:	56                   	push   %esi
80106ad2:	ff 70 10             	push   0x10(%eax)
80106ad5:	68 48 8c 10 80       	push   $0x80108c48
80106ada:	e8 b1 9c ff ff       	call   80100790 <cprintf>
    myproc()->killed = 1;
80106adf:	83 c4 20             	add    $0x20,%esp
80106ae2:	e8 f9 da ff ff       	call   801045e0 <myproc>
80106ae7:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106aee:	e8 ed da ff ff       	call   801045e0 <myproc>
80106af3:	85 c0                	test   %eax,%eax
80106af5:	0f 85 18 ff ff ff    	jne    80106a13 <trap+0x43>
80106afb:	e9 30 ff ff ff       	jmp    80106a30 <trap+0x60>
  if(myproc() && myproc()->state == RUNNING &&
80106b00:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80106b04:	0f 85 3e ff ff ff    	jne    80106a48 <trap+0x78>
    yield();
80106b0a:	e8 f1 e2 ff ff       	call   80104e00 <yield>
80106b0f:	e9 34 ff ff ff       	jmp    80106a48 <trap+0x78>
80106b14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106b18:	8b 7b 38             	mov    0x38(%ebx),%edi
80106b1b:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80106b1f:	e8 9c da ff ff       	call   801045c0 <cpuid>
80106b24:	57                   	push   %edi
80106b25:	56                   	push   %esi
80106b26:	50                   	push   %eax
80106b27:	68 f0 8b 10 80       	push   $0x80108bf0
80106b2c:	e8 5f 9c ff ff       	call   80100790 <cprintf>
    lapiceoi();
80106b31:	e8 0a ca ff ff       	call   80103540 <lapiceoi>
    break;
80106b36:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106b39:	e8 a2 da ff ff       	call   801045e0 <myproc>
80106b3e:	85 c0                	test   %eax,%eax
80106b40:	0f 85 cd fe ff ff    	jne    80106a13 <trap+0x43>
80106b46:	e9 e5 fe ff ff       	jmp    80106a30 <trap+0x60>
80106b4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106b4f:	90                   	nop
    if(myproc()->killed)
80106b50:	e8 8b da ff ff       	call   801045e0 <myproc>
80106b55:	8b 70 24             	mov    0x24(%eax),%esi
80106b58:	85 f6                	test   %esi,%esi
80106b5a:	0f 85 d0 00 00 00    	jne    80106c30 <trap+0x260>
    myproc()->tf = tf;
80106b60:	e8 7b da ff ff       	call   801045e0 <myproc>
80106b65:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80106b68:	e8 93 ee ff ff       	call   80105a00 <syscall>
    if(myproc()->killed)
80106b6d:	e8 6e da ff ff       	call   801045e0 <myproc>
80106b72:	8b 48 24             	mov    0x24(%eax),%ecx
80106b75:	85 c9                	test   %ecx,%ecx
80106b77:	0f 84 f1 fe ff ff    	je     80106a6e <trap+0x9e>
}
80106b7d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106b80:	5b                   	pop    %ebx
80106b81:	5e                   	pop    %esi
80106b82:	5f                   	pop    %edi
80106b83:	5d                   	pop    %ebp
      exit();
80106b84:	e9 97 de ff ff       	jmp    80104a20 <exit>
80106b89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80106b90:	e8 4b 02 00 00       	call   80106de0 <uartintr>
    lapiceoi();
80106b95:	e8 a6 c9 ff ff       	call   80103540 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106b9a:	e8 41 da ff ff       	call   801045e0 <myproc>
80106b9f:	85 c0                	test   %eax,%eax
80106ba1:	0f 85 6c fe ff ff    	jne    80106a13 <trap+0x43>
80106ba7:	e9 84 fe ff ff       	jmp    80106a30 <trap+0x60>
80106bac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80106bb0:	e8 4b c8 ff ff       	call   80103400 <kbdintr>
    lapiceoi();
80106bb5:	e8 86 c9 ff ff       	call   80103540 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106bba:	e8 21 da ff ff       	call   801045e0 <myproc>
80106bbf:	85 c0                	test   %eax,%eax
80106bc1:	0f 85 4c fe ff ff    	jne    80106a13 <trap+0x43>
80106bc7:	e9 64 fe ff ff       	jmp    80106a30 <trap+0x60>
80106bcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
80106bd0:	e8 eb d9 ff ff       	call   801045c0 <cpuid>
80106bd5:	85 c0                	test   %eax,%eax
80106bd7:	0f 85 28 fe ff ff    	jne    80106a05 <trap+0x35>
      acquire(&tickslock);
80106bdd:	83 ec 0c             	sub    $0xc,%esp
80106be0:	68 80 5d 11 80       	push   $0x80115d80
80106be5:	e8 06 e9 ff ff       	call   801054f0 <acquire>
      ticks++;
80106bea:	83 05 60 5d 11 80 01 	addl   $0x1,0x80115d60
      updateStatistics(); // so that stats get updated with every tick of clock
80106bf1:	e8 7a e5 ff ff       	call   80105170 <updateStatistics>
      wakeup(&ticks);
80106bf6:	c7 04 24 60 5d 11 80 	movl   $0x80115d60,(%esp)
80106bfd:	e8 0e e3 ff ff       	call   80104f10 <wakeup>
      release(&tickslock);
80106c02:	c7 04 24 80 5d 11 80 	movl   $0x80115d80,(%esp)
80106c09:	e8 82 e8 ff ff       	call   80105490 <release>
80106c0e:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
80106c11:	e9 ef fd ff ff       	jmp    80106a05 <trap+0x35>
80106c16:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106c1d:	8d 76 00             	lea    0x0(%esi),%esi
    exit();
80106c20:	e8 fb dd ff ff       	call   80104a20 <exit>
80106c25:	e9 06 fe ff ff       	jmp    80106a30 <trap+0x60>
80106c2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80106c30:	e8 eb dd ff ff       	call   80104a20 <exit>
80106c35:	e9 26 ff ff ff       	jmp    80106b60 <trap+0x190>
80106c3a:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106c3d:	e8 7e d9 ff ff       	call   801045c0 <cpuid>
80106c42:	83 ec 0c             	sub    $0xc,%esp
80106c45:	56                   	push   %esi
80106c46:	57                   	push   %edi
80106c47:	50                   	push   %eax
80106c48:	ff 73 30             	push   0x30(%ebx)
80106c4b:	68 14 8c 10 80       	push   $0x80108c14
80106c50:	e8 3b 9b ff ff       	call   80100790 <cprintf>
      panic("trap");
80106c55:	83 c4 14             	add    $0x14,%esp
80106c58:	68 e9 8b 10 80       	push   $0x80108be9
80106c5d:	e8 1e 97 ff ff       	call   80100380 <panic>
80106c62:	66 90                	xchg   %ax,%ax
80106c64:	66 90                	xchg   %ax,%ax
80106c66:	66 90                	xchg   %ax,%ax
80106c68:	66 90                	xchg   %ax,%ax
80106c6a:	66 90                	xchg   %ax,%ax
80106c6c:	66 90                	xchg   %ax,%ax
80106c6e:	66 90                	xchg   %ax,%ax

80106c70 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106c70:	a1 c0 65 11 80       	mov    0x801165c0,%eax
80106c75:	85 c0                	test   %eax,%eax
80106c77:	74 17                	je     80106c90 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106c79:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106c7e:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80106c7f:	a8 01                	test   $0x1,%al
80106c81:	74 0d                	je     80106c90 <uartgetc+0x20>
80106c83:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106c88:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80106c89:	0f b6 c0             	movzbl %al,%eax
80106c8c:	c3                   	ret    
80106c8d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80106c90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106c95:	c3                   	ret    
80106c96:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106c9d:	8d 76 00             	lea    0x0(%esi),%esi

80106ca0 <uartinit>:
{
80106ca0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106ca1:	31 c9                	xor    %ecx,%ecx
80106ca3:	89 c8                	mov    %ecx,%eax
80106ca5:	89 e5                	mov    %esp,%ebp
80106ca7:	57                   	push   %edi
80106ca8:	bf fa 03 00 00       	mov    $0x3fa,%edi
80106cad:	56                   	push   %esi
80106cae:	89 fa                	mov    %edi,%edx
80106cb0:	53                   	push   %ebx
80106cb1:	83 ec 1c             	sub    $0x1c,%esp
80106cb4:	ee                   	out    %al,(%dx)
80106cb5:	be fb 03 00 00       	mov    $0x3fb,%esi
80106cba:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80106cbf:	89 f2                	mov    %esi,%edx
80106cc1:	ee                   	out    %al,(%dx)
80106cc2:	b8 0c 00 00 00       	mov    $0xc,%eax
80106cc7:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106ccc:	ee                   	out    %al,(%dx)
80106ccd:	bb f9 03 00 00       	mov    $0x3f9,%ebx
80106cd2:	89 c8                	mov    %ecx,%eax
80106cd4:	89 da                	mov    %ebx,%edx
80106cd6:	ee                   	out    %al,(%dx)
80106cd7:	b8 03 00 00 00       	mov    $0x3,%eax
80106cdc:	89 f2                	mov    %esi,%edx
80106cde:	ee                   	out    %al,(%dx)
80106cdf:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106ce4:	89 c8                	mov    %ecx,%eax
80106ce6:	ee                   	out    %al,(%dx)
80106ce7:	b8 01 00 00 00       	mov    $0x1,%eax
80106cec:	89 da                	mov    %ebx,%edx
80106cee:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106cef:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106cf4:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80106cf5:	3c ff                	cmp    $0xff,%al
80106cf7:	74 78                	je     80106d71 <uartinit+0xd1>
  uart = 1;
80106cf9:	c7 05 c0 65 11 80 01 	movl   $0x1,0x801165c0
80106d00:	00 00 00 
80106d03:	89 fa                	mov    %edi,%edx
80106d05:	ec                   	in     (%dx),%al
80106d06:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106d0b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80106d0c:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
80106d0f:	bf 0c 8d 10 80       	mov    $0x80108d0c,%edi
80106d14:	be fd 03 00 00       	mov    $0x3fd,%esi
  ioapicenable(IRQ_COM1, 0);
80106d19:	6a 00                	push   $0x0
80106d1b:	6a 04                	push   $0x4
80106d1d:	e8 8e c3 ff ff       	call   801030b0 <ioapicenable>
  for(p="xv6...\n"; *p; p++)
80106d22:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
  ioapicenable(IRQ_COM1, 0);
80106d26:	83 c4 10             	add    $0x10,%esp
80106d29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(!uart)
80106d30:	a1 c0 65 11 80       	mov    0x801165c0,%eax
80106d35:	bb 80 00 00 00       	mov    $0x80,%ebx
80106d3a:	85 c0                	test   %eax,%eax
80106d3c:	75 14                	jne    80106d52 <uartinit+0xb2>
80106d3e:	eb 23                	jmp    80106d63 <uartinit+0xc3>
    microdelay(10);
80106d40:	83 ec 0c             	sub    $0xc,%esp
80106d43:	6a 0a                	push   $0xa
80106d45:	e8 16 c8 ff ff       	call   80103560 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106d4a:	83 c4 10             	add    $0x10,%esp
80106d4d:	83 eb 01             	sub    $0x1,%ebx
80106d50:	74 07                	je     80106d59 <uartinit+0xb9>
80106d52:	89 f2                	mov    %esi,%edx
80106d54:	ec                   	in     (%dx),%al
80106d55:	a8 20                	test   $0x20,%al
80106d57:	74 e7                	je     80106d40 <uartinit+0xa0>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106d59:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
80106d5d:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106d62:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
80106d63:	0f b6 47 01          	movzbl 0x1(%edi),%eax
80106d67:	83 c7 01             	add    $0x1,%edi
80106d6a:	88 45 e7             	mov    %al,-0x19(%ebp)
80106d6d:	84 c0                	test   %al,%al
80106d6f:	75 bf                	jne    80106d30 <uartinit+0x90>
}
80106d71:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d74:	5b                   	pop    %ebx
80106d75:	5e                   	pop    %esi
80106d76:	5f                   	pop    %edi
80106d77:	5d                   	pop    %ebp
80106d78:	c3                   	ret    
80106d79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106d80 <uartputc>:
  if(!uart)
80106d80:	a1 c0 65 11 80       	mov    0x801165c0,%eax
80106d85:	85 c0                	test   %eax,%eax
80106d87:	74 47                	je     80106dd0 <uartputc+0x50>
{
80106d89:	55                   	push   %ebp
80106d8a:	89 e5                	mov    %esp,%ebp
80106d8c:	56                   	push   %esi
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106d8d:	be fd 03 00 00       	mov    $0x3fd,%esi
80106d92:	53                   	push   %ebx
80106d93:	bb 80 00 00 00       	mov    $0x80,%ebx
80106d98:	eb 18                	jmp    80106db2 <uartputc+0x32>
80106d9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    microdelay(10);
80106da0:	83 ec 0c             	sub    $0xc,%esp
80106da3:	6a 0a                	push   $0xa
80106da5:	e8 b6 c7 ff ff       	call   80103560 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106daa:	83 c4 10             	add    $0x10,%esp
80106dad:	83 eb 01             	sub    $0x1,%ebx
80106db0:	74 07                	je     80106db9 <uartputc+0x39>
80106db2:	89 f2                	mov    %esi,%edx
80106db4:	ec                   	in     (%dx),%al
80106db5:	a8 20                	test   $0x20,%al
80106db7:	74 e7                	je     80106da0 <uartputc+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106db9:	8b 45 08             	mov    0x8(%ebp),%eax
80106dbc:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106dc1:	ee                   	out    %al,(%dx)
}
80106dc2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106dc5:	5b                   	pop    %ebx
80106dc6:	5e                   	pop    %esi
80106dc7:	5d                   	pop    %ebp
80106dc8:	c3                   	ret    
80106dc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106dd0:	c3                   	ret    
80106dd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106dd8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106ddf:	90                   	nop

80106de0 <uartintr>:

void
uartintr(void)
{
80106de0:	55                   	push   %ebp
80106de1:	89 e5                	mov    %esp,%ebp
80106de3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80106de6:	68 70 6c 10 80       	push   $0x80106c70
80106deb:	e8 d0 9f ff ff       	call   80100dc0 <consoleintr>
}
80106df0:	83 c4 10             	add    $0x10,%esp
80106df3:	c9                   	leave  
80106df4:	c3                   	ret    

80106df5 <vector0>:
80106df5:	6a 00                	push   $0x0
80106df7:	6a 00                	push   $0x0
80106df9:	e9 f1 fa ff ff       	jmp    801068ef <alltraps>

80106dfe <vector1>:
80106dfe:	6a 00                	push   $0x0
80106e00:	6a 01                	push   $0x1
80106e02:	e9 e8 fa ff ff       	jmp    801068ef <alltraps>

80106e07 <vector2>:
80106e07:	6a 00                	push   $0x0
80106e09:	6a 02                	push   $0x2
80106e0b:	e9 df fa ff ff       	jmp    801068ef <alltraps>

80106e10 <vector3>:
80106e10:	6a 00                	push   $0x0
80106e12:	6a 03                	push   $0x3
80106e14:	e9 d6 fa ff ff       	jmp    801068ef <alltraps>

80106e19 <vector4>:
80106e19:	6a 00                	push   $0x0
80106e1b:	6a 04                	push   $0x4
80106e1d:	e9 cd fa ff ff       	jmp    801068ef <alltraps>

80106e22 <vector5>:
80106e22:	6a 00                	push   $0x0
80106e24:	6a 05                	push   $0x5
80106e26:	e9 c4 fa ff ff       	jmp    801068ef <alltraps>

80106e2b <vector6>:
80106e2b:	6a 00                	push   $0x0
80106e2d:	6a 06                	push   $0x6
80106e2f:	e9 bb fa ff ff       	jmp    801068ef <alltraps>

80106e34 <vector7>:
80106e34:	6a 00                	push   $0x0
80106e36:	6a 07                	push   $0x7
80106e38:	e9 b2 fa ff ff       	jmp    801068ef <alltraps>

80106e3d <vector8>:
80106e3d:	6a 08                	push   $0x8
80106e3f:	e9 ab fa ff ff       	jmp    801068ef <alltraps>

80106e44 <vector9>:
80106e44:	6a 00                	push   $0x0
80106e46:	6a 09                	push   $0x9
80106e48:	e9 a2 fa ff ff       	jmp    801068ef <alltraps>

80106e4d <vector10>:
80106e4d:	6a 0a                	push   $0xa
80106e4f:	e9 9b fa ff ff       	jmp    801068ef <alltraps>

80106e54 <vector11>:
80106e54:	6a 0b                	push   $0xb
80106e56:	e9 94 fa ff ff       	jmp    801068ef <alltraps>

80106e5b <vector12>:
80106e5b:	6a 0c                	push   $0xc
80106e5d:	e9 8d fa ff ff       	jmp    801068ef <alltraps>

80106e62 <vector13>:
80106e62:	6a 0d                	push   $0xd
80106e64:	e9 86 fa ff ff       	jmp    801068ef <alltraps>

80106e69 <vector14>:
80106e69:	6a 0e                	push   $0xe
80106e6b:	e9 7f fa ff ff       	jmp    801068ef <alltraps>

80106e70 <vector15>:
80106e70:	6a 00                	push   $0x0
80106e72:	6a 0f                	push   $0xf
80106e74:	e9 76 fa ff ff       	jmp    801068ef <alltraps>

80106e79 <vector16>:
80106e79:	6a 00                	push   $0x0
80106e7b:	6a 10                	push   $0x10
80106e7d:	e9 6d fa ff ff       	jmp    801068ef <alltraps>

80106e82 <vector17>:
80106e82:	6a 11                	push   $0x11
80106e84:	e9 66 fa ff ff       	jmp    801068ef <alltraps>

80106e89 <vector18>:
80106e89:	6a 00                	push   $0x0
80106e8b:	6a 12                	push   $0x12
80106e8d:	e9 5d fa ff ff       	jmp    801068ef <alltraps>

80106e92 <vector19>:
80106e92:	6a 00                	push   $0x0
80106e94:	6a 13                	push   $0x13
80106e96:	e9 54 fa ff ff       	jmp    801068ef <alltraps>

80106e9b <vector20>:
80106e9b:	6a 00                	push   $0x0
80106e9d:	6a 14                	push   $0x14
80106e9f:	e9 4b fa ff ff       	jmp    801068ef <alltraps>

80106ea4 <vector21>:
80106ea4:	6a 00                	push   $0x0
80106ea6:	6a 15                	push   $0x15
80106ea8:	e9 42 fa ff ff       	jmp    801068ef <alltraps>

80106ead <vector22>:
80106ead:	6a 00                	push   $0x0
80106eaf:	6a 16                	push   $0x16
80106eb1:	e9 39 fa ff ff       	jmp    801068ef <alltraps>

80106eb6 <vector23>:
80106eb6:	6a 00                	push   $0x0
80106eb8:	6a 17                	push   $0x17
80106eba:	e9 30 fa ff ff       	jmp    801068ef <alltraps>

80106ebf <vector24>:
80106ebf:	6a 00                	push   $0x0
80106ec1:	6a 18                	push   $0x18
80106ec3:	e9 27 fa ff ff       	jmp    801068ef <alltraps>

80106ec8 <vector25>:
80106ec8:	6a 00                	push   $0x0
80106eca:	6a 19                	push   $0x19
80106ecc:	e9 1e fa ff ff       	jmp    801068ef <alltraps>

80106ed1 <vector26>:
80106ed1:	6a 00                	push   $0x0
80106ed3:	6a 1a                	push   $0x1a
80106ed5:	e9 15 fa ff ff       	jmp    801068ef <alltraps>

80106eda <vector27>:
80106eda:	6a 00                	push   $0x0
80106edc:	6a 1b                	push   $0x1b
80106ede:	e9 0c fa ff ff       	jmp    801068ef <alltraps>

80106ee3 <vector28>:
80106ee3:	6a 00                	push   $0x0
80106ee5:	6a 1c                	push   $0x1c
80106ee7:	e9 03 fa ff ff       	jmp    801068ef <alltraps>

80106eec <vector29>:
80106eec:	6a 00                	push   $0x0
80106eee:	6a 1d                	push   $0x1d
80106ef0:	e9 fa f9 ff ff       	jmp    801068ef <alltraps>

80106ef5 <vector30>:
80106ef5:	6a 00                	push   $0x0
80106ef7:	6a 1e                	push   $0x1e
80106ef9:	e9 f1 f9 ff ff       	jmp    801068ef <alltraps>

80106efe <vector31>:
80106efe:	6a 00                	push   $0x0
80106f00:	6a 1f                	push   $0x1f
80106f02:	e9 e8 f9 ff ff       	jmp    801068ef <alltraps>

80106f07 <vector32>:
80106f07:	6a 00                	push   $0x0
80106f09:	6a 20                	push   $0x20
80106f0b:	e9 df f9 ff ff       	jmp    801068ef <alltraps>

80106f10 <vector33>:
80106f10:	6a 00                	push   $0x0
80106f12:	6a 21                	push   $0x21
80106f14:	e9 d6 f9 ff ff       	jmp    801068ef <alltraps>

80106f19 <vector34>:
80106f19:	6a 00                	push   $0x0
80106f1b:	6a 22                	push   $0x22
80106f1d:	e9 cd f9 ff ff       	jmp    801068ef <alltraps>

80106f22 <vector35>:
80106f22:	6a 00                	push   $0x0
80106f24:	6a 23                	push   $0x23
80106f26:	e9 c4 f9 ff ff       	jmp    801068ef <alltraps>

80106f2b <vector36>:
80106f2b:	6a 00                	push   $0x0
80106f2d:	6a 24                	push   $0x24
80106f2f:	e9 bb f9 ff ff       	jmp    801068ef <alltraps>

80106f34 <vector37>:
80106f34:	6a 00                	push   $0x0
80106f36:	6a 25                	push   $0x25
80106f38:	e9 b2 f9 ff ff       	jmp    801068ef <alltraps>

80106f3d <vector38>:
80106f3d:	6a 00                	push   $0x0
80106f3f:	6a 26                	push   $0x26
80106f41:	e9 a9 f9 ff ff       	jmp    801068ef <alltraps>

80106f46 <vector39>:
80106f46:	6a 00                	push   $0x0
80106f48:	6a 27                	push   $0x27
80106f4a:	e9 a0 f9 ff ff       	jmp    801068ef <alltraps>

80106f4f <vector40>:
80106f4f:	6a 00                	push   $0x0
80106f51:	6a 28                	push   $0x28
80106f53:	e9 97 f9 ff ff       	jmp    801068ef <alltraps>

80106f58 <vector41>:
80106f58:	6a 00                	push   $0x0
80106f5a:	6a 29                	push   $0x29
80106f5c:	e9 8e f9 ff ff       	jmp    801068ef <alltraps>

80106f61 <vector42>:
80106f61:	6a 00                	push   $0x0
80106f63:	6a 2a                	push   $0x2a
80106f65:	e9 85 f9 ff ff       	jmp    801068ef <alltraps>

80106f6a <vector43>:
80106f6a:	6a 00                	push   $0x0
80106f6c:	6a 2b                	push   $0x2b
80106f6e:	e9 7c f9 ff ff       	jmp    801068ef <alltraps>

80106f73 <vector44>:
80106f73:	6a 00                	push   $0x0
80106f75:	6a 2c                	push   $0x2c
80106f77:	e9 73 f9 ff ff       	jmp    801068ef <alltraps>

80106f7c <vector45>:
80106f7c:	6a 00                	push   $0x0
80106f7e:	6a 2d                	push   $0x2d
80106f80:	e9 6a f9 ff ff       	jmp    801068ef <alltraps>

80106f85 <vector46>:
80106f85:	6a 00                	push   $0x0
80106f87:	6a 2e                	push   $0x2e
80106f89:	e9 61 f9 ff ff       	jmp    801068ef <alltraps>

80106f8e <vector47>:
80106f8e:	6a 00                	push   $0x0
80106f90:	6a 2f                	push   $0x2f
80106f92:	e9 58 f9 ff ff       	jmp    801068ef <alltraps>

80106f97 <vector48>:
80106f97:	6a 00                	push   $0x0
80106f99:	6a 30                	push   $0x30
80106f9b:	e9 4f f9 ff ff       	jmp    801068ef <alltraps>

80106fa0 <vector49>:
80106fa0:	6a 00                	push   $0x0
80106fa2:	6a 31                	push   $0x31
80106fa4:	e9 46 f9 ff ff       	jmp    801068ef <alltraps>

80106fa9 <vector50>:
80106fa9:	6a 00                	push   $0x0
80106fab:	6a 32                	push   $0x32
80106fad:	e9 3d f9 ff ff       	jmp    801068ef <alltraps>

80106fb2 <vector51>:
80106fb2:	6a 00                	push   $0x0
80106fb4:	6a 33                	push   $0x33
80106fb6:	e9 34 f9 ff ff       	jmp    801068ef <alltraps>

80106fbb <vector52>:
80106fbb:	6a 00                	push   $0x0
80106fbd:	6a 34                	push   $0x34
80106fbf:	e9 2b f9 ff ff       	jmp    801068ef <alltraps>

80106fc4 <vector53>:
80106fc4:	6a 00                	push   $0x0
80106fc6:	6a 35                	push   $0x35
80106fc8:	e9 22 f9 ff ff       	jmp    801068ef <alltraps>

80106fcd <vector54>:
80106fcd:	6a 00                	push   $0x0
80106fcf:	6a 36                	push   $0x36
80106fd1:	e9 19 f9 ff ff       	jmp    801068ef <alltraps>

80106fd6 <vector55>:
80106fd6:	6a 00                	push   $0x0
80106fd8:	6a 37                	push   $0x37
80106fda:	e9 10 f9 ff ff       	jmp    801068ef <alltraps>

80106fdf <vector56>:
80106fdf:	6a 00                	push   $0x0
80106fe1:	6a 38                	push   $0x38
80106fe3:	e9 07 f9 ff ff       	jmp    801068ef <alltraps>

80106fe8 <vector57>:
80106fe8:	6a 00                	push   $0x0
80106fea:	6a 39                	push   $0x39
80106fec:	e9 fe f8 ff ff       	jmp    801068ef <alltraps>

80106ff1 <vector58>:
80106ff1:	6a 00                	push   $0x0
80106ff3:	6a 3a                	push   $0x3a
80106ff5:	e9 f5 f8 ff ff       	jmp    801068ef <alltraps>

80106ffa <vector59>:
80106ffa:	6a 00                	push   $0x0
80106ffc:	6a 3b                	push   $0x3b
80106ffe:	e9 ec f8 ff ff       	jmp    801068ef <alltraps>

80107003 <vector60>:
80107003:	6a 00                	push   $0x0
80107005:	6a 3c                	push   $0x3c
80107007:	e9 e3 f8 ff ff       	jmp    801068ef <alltraps>

8010700c <vector61>:
8010700c:	6a 00                	push   $0x0
8010700e:	6a 3d                	push   $0x3d
80107010:	e9 da f8 ff ff       	jmp    801068ef <alltraps>

80107015 <vector62>:
80107015:	6a 00                	push   $0x0
80107017:	6a 3e                	push   $0x3e
80107019:	e9 d1 f8 ff ff       	jmp    801068ef <alltraps>

8010701e <vector63>:
8010701e:	6a 00                	push   $0x0
80107020:	6a 3f                	push   $0x3f
80107022:	e9 c8 f8 ff ff       	jmp    801068ef <alltraps>

80107027 <vector64>:
80107027:	6a 00                	push   $0x0
80107029:	6a 40                	push   $0x40
8010702b:	e9 bf f8 ff ff       	jmp    801068ef <alltraps>

80107030 <vector65>:
80107030:	6a 00                	push   $0x0
80107032:	6a 41                	push   $0x41
80107034:	e9 b6 f8 ff ff       	jmp    801068ef <alltraps>

80107039 <vector66>:
80107039:	6a 00                	push   $0x0
8010703b:	6a 42                	push   $0x42
8010703d:	e9 ad f8 ff ff       	jmp    801068ef <alltraps>

80107042 <vector67>:
80107042:	6a 00                	push   $0x0
80107044:	6a 43                	push   $0x43
80107046:	e9 a4 f8 ff ff       	jmp    801068ef <alltraps>

8010704b <vector68>:
8010704b:	6a 00                	push   $0x0
8010704d:	6a 44                	push   $0x44
8010704f:	e9 9b f8 ff ff       	jmp    801068ef <alltraps>

80107054 <vector69>:
80107054:	6a 00                	push   $0x0
80107056:	6a 45                	push   $0x45
80107058:	e9 92 f8 ff ff       	jmp    801068ef <alltraps>

8010705d <vector70>:
8010705d:	6a 00                	push   $0x0
8010705f:	6a 46                	push   $0x46
80107061:	e9 89 f8 ff ff       	jmp    801068ef <alltraps>

80107066 <vector71>:
80107066:	6a 00                	push   $0x0
80107068:	6a 47                	push   $0x47
8010706a:	e9 80 f8 ff ff       	jmp    801068ef <alltraps>

8010706f <vector72>:
8010706f:	6a 00                	push   $0x0
80107071:	6a 48                	push   $0x48
80107073:	e9 77 f8 ff ff       	jmp    801068ef <alltraps>

80107078 <vector73>:
80107078:	6a 00                	push   $0x0
8010707a:	6a 49                	push   $0x49
8010707c:	e9 6e f8 ff ff       	jmp    801068ef <alltraps>

80107081 <vector74>:
80107081:	6a 00                	push   $0x0
80107083:	6a 4a                	push   $0x4a
80107085:	e9 65 f8 ff ff       	jmp    801068ef <alltraps>

8010708a <vector75>:
8010708a:	6a 00                	push   $0x0
8010708c:	6a 4b                	push   $0x4b
8010708e:	e9 5c f8 ff ff       	jmp    801068ef <alltraps>

80107093 <vector76>:
80107093:	6a 00                	push   $0x0
80107095:	6a 4c                	push   $0x4c
80107097:	e9 53 f8 ff ff       	jmp    801068ef <alltraps>

8010709c <vector77>:
8010709c:	6a 00                	push   $0x0
8010709e:	6a 4d                	push   $0x4d
801070a0:	e9 4a f8 ff ff       	jmp    801068ef <alltraps>

801070a5 <vector78>:
801070a5:	6a 00                	push   $0x0
801070a7:	6a 4e                	push   $0x4e
801070a9:	e9 41 f8 ff ff       	jmp    801068ef <alltraps>

801070ae <vector79>:
801070ae:	6a 00                	push   $0x0
801070b0:	6a 4f                	push   $0x4f
801070b2:	e9 38 f8 ff ff       	jmp    801068ef <alltraps>

801070b7 <vector80>:
801070b7:	6a 00                	push   $0x0
801070b9:	6a 50                	push   $0x50
801070bb:	e9 2f f8 ff ff       	jmp    801068ef <alltraps>

801070c0 <vector81>:
801070c0:	6a 00                	push   $0x0
801070c2:	6a 51                	push   $0x51
801070c4:	e9 26 f8 ff ff       	jmp    801068ef <alltraps>

801070c9 <vector82>:
801070c9:	6a 00                	push   $0x0
801070cb:	6a 52                	push   $0x52
801070cd:	e9 1d f8 ff ff       	jmp    801068ef <alltraps>

801070d2 <vector83>:
801070d2:	6a 00                	push   $0x0
801070d4:	6a 53                	push   $0x53
801070d6:	e9 14 f8 ff ff       	jmp    801068ef <alltraps>

801070db <vector84>:
801070db:	6a 00                	push   $0x0
801070dd:	6a 54                	push   $0x54
801070df:	e9 0b f8 ff ff       	jmp    801068ef <alltraps>

801070e4 <vector85>:
801070e4:	6a 00                	push   $0x0
801070e6:	6a 55                	push   $0x55
801070e8:	e9 02 f8 ff ff       	jmp    801068ef <alltraps>

801070ed <vector86>:
801070ed:	6a 00                	push   $0x0
801070ef:	6a 56                	push   $0x56
801070f1:	e9 f9 f7 ff ff       	jmp    801068ef <alltraps>

801070f6 <vector87>:
801070f6:	6a 00                	push   $0x0
801070f8:	6a 57                	push   $0x57
801070fa:	e9 f0 f7 ff ff       	jmp    801068ef <alltraps>

801070ff <vector88>:
801070ff:	6a 00                	push   $0x0
80107101:	6a 58                	push   $0x58
80107103:	e9 e7 f7 ff ff       	jmp    801068ef <alltraps>

80107108 <vector89>:
80107108:	6a 00                	push   $0x0
8010710a:	6a 59                	push   $0x59
8010710c:	e9 de f7 ff ff       	jmp    801068ef <alltraps>

80107111 <vector90>:
80107111:	6a 00                	push   $0x0
80107113:	6a 5a                	push   $0x5a
80107115:	e9 d5 f7 ff ff       	jmp    801068ef <alltraps>

8010711a <vector91>:
8010711a:	6a 00                	push   $0x0
8010711c:	6a 5b                	push   $0x5b
8010711e:	e9 cc f7 ff ff       	jmp    801068ef <alltraps>

80107123 <vector92>:
80107123:	6a 00                	push   $0x0
80107125:	6a 5c                	push   $0x5c
80107127:	e9 c3 f7 ff ff       	jmp    801068ef <alltraps>

8010712c <vector93>:
8010712c:	6a 00                	push   $0x0
8010712e:	6a 5d                	push   $0x5d
80107130:	e9 ba f7 ff ff       	jmp    801068ef <alltraps>

80107135 <vector94>:
80107135:	6a 00                	push   $0x0
80107137:	6a 5e                	push   $0x5e
80107139:	e9 b1 f7 ff ff       	jmp    801068ef <alltraps>

8010713e <vector95>:
8010713e:	6a 00                	push   $0x0
80107140:	6a 5f                	push   $0x5f
80107142:	e9 a8 f7 ff ff       	jmp    801068ef <alltraps>

80107147 <vector96>:
80107147:	6a 00                	push   $0x0
80107149:	6a 60                	push   $0x60
8010714b:	e9 9f f7 ff ff       	jmp    801068ef <alltraps>

80107150 <vector97>:
80107150:	6a 00                	push   $0x0
80107152:	6a 61                	push   $0x61
80107154:	e9 96 f7 ff ff       	jmp    801068ef <alltraps>

80107159 <vector98>:
80107159:	6a 00                	push   $0x0
8010715b:	6a 62                	push   $0x62
8010715d:	e9 8d f7 ff ff       	jmp    801068ef <alltraps>

80107162 <vector99>:
80107162:	6a 00                	push   $0x0
80107164:	6a 63                	push   $0x63
80107166:	e9 84 f7 ff ff       	jmp    801068ef <alltraps>

8010716b <vector100>:
8010716b:	6a 00                	push   $0x0
8010716d:	6a 64                	push   $0x64
8010716f:	e9 7b f7 ff ff       	jmp    801068ef <alltraps>

80107174 <vector101>:
80107174:	6a 00                	push   $0x0
80107176:	6a 65                	push   $0x65
80107178:	e9 72 f7 ff ff       	jmp    801068ef <alltraps>

8010717d <vector102>:
8010717d:	6a 00                	push   $0x0
8010717f:	6a 66                	push   $0x66
80107181:	e9 69 f7 ff ff       	jmp    801068ef <alltraps>

80107186 <vector103>:
80107186:	6a 00                	push   $0x0
80107188:	6a 67                	push   $0x67
8010718a:	e9 60 f7 ff ff       	jmp    801068ef <alltraps>

8010718f <vector104>:
8010718f:	6a 00                	push   $0x0
80107191:	6a 68                	push   $0x68
80107193:	e9 57 f7 ff ff       	jmp    801068ef <alltraps>

80107198 <vector105>:
80107198:	6a 00                	push   $0x0
8010719a:	6a 69                	push   $0x69
8010719c:	e9 4e f7 ff ff       	jmp    801068ef <alltraps>

801071a1 <vector106>:
801071a1:	6a 00                	push   $0x0
801071a3:	6a 6a                	push   $0x6a
801071a5:	e9 45 f7 ff ff       	jmp    801068ef <alltraps>

801071aa <vector107>:
801071aa:	6a 00                	push   $0x0
801071ac:	6a 6b                	push   $0x6b
801071ae:	e9 3c f7 ff ff       	jmp    801068ef <alltraps>

801071b3 <vector108>:
801071b3:	6a 00                	push   $0x0
801071b5:	6a 6c                	push   $0x6c
801071b7:	e9 33 f7 ff ff       	jmp    801068ef <alltraps>

801071bc <vector109>:
801071bc:	6a 00                	push   $0x0
801071be:	6a 6d                	push   $0x6d
801071c0:	e9 2a f7 ff ff       	jmp    801068ef <alltraps>

801071c5 <vector110>:
801071c5:	6a 00                	push   $0x0
801071c7:	6a 6e                	push   $0x6e
801071c9:	e9 21 f7 ff ff       	jmp    801068ef <alltraps>

801071ce <vector111>:
801071ce:	6a 00                	push   $0x0
801071d0:	6a 6f                	push   $0x6f
801071d2:	e9 18 f7 ff ff       	jmp    801068ef <alltraps>

801071d7 <vector112>:
801071d7:	6a 00                	push   $0x0
801071d9:	6a 70                	push   $0x70
801071db:	e9 0f f7 ff ff       	jmp    801068ef <alltraps>

801071e0 <vector113>:
801071e0:	6a 00                	push   $0x0
801071e2:	6a 71                	push   $0x71
801071e4:	e9 06 f7 ff ff       	jmp    801068ef <alltraps>

801071e9 <vector114>:
801071e9:	6a 00                	push   $0x0
801071eb:	6a 72                	push   $0x72
801071ed:	e9 fd f6 ff ff       	jmp    801068ef <alltraps>

801071f2 <vector115>:
801071f2:	6a 00                	push   $0x0
801071f4:	6a 73                	push   $0x73
801071f6:	e9 f4 f6 ff ff       	jmp    801068ef <alltraps>

801071fb <vector116>:
801071fb:	6a 00                	push   $0x0
801071fd:	6a 74                	push   $0x74
801071ff:	e9 eb f6 ff ff       	jmp    801068ef <alltraps>

80107204 <vector117>:
80107204:	6a 00                	push   $0x0
80107206:	6a 75                	push   $0x75
80107208:	e9 e2 f6 ff ff       	jmp    801068ef <alltraps>

8010720d <vector118>:
8010720d:	6a 00                	push   $0x0
8010720f:	6a 76                	push   $0x76
80107211:	e9 d9 f6 ff ff       	jmp    801068ef <alltraps>

80107216 <vector119>:
80107216:	6a 00                	push   $0x0
80107218:	6a 77                	push   $0x77
8010721a:	e9 d0 f6 ff ff       	jmp    801068ef <alltraps>

8010721f <vector120>:
8010721f:	6a 00                	push   $0x0
80107221:	6a 78                	push   $0x78
80107223:	e9 c7 f6 ff ff       	jmp    801068ef <alltraps>

80107228 <vector121>:
80107228:	6a 00                	push   $0x0
8010722a:	6a 79                	push   $0x79
8010722c:	e9 be f6 ff ff       	jmp    801068ef <alltraps>

80107231 <vector122>:
80107231:	6a 00                	push   $0x0
80107233:	6a 7a                	push   $0x7a
80107235:	e9 b5 f6 ff ff       	jmp    801068ef <alltraps>

8010723a <vector123>:
8010723a:	6a 00                	push   $0x0
8010723c:	6a 7b                	push   $0x7b
8010723e:	e9 ac f6 ff ff       	jmp    801068ef <alltraps>

80107243 <vector124>:
80107243:	6a 00                	push   $0x0
80107245:	6a 7c                	push   $0x7c
80107247:	e9 a3 f6 ff ff       	jmp    801068ef <alltraps>

8010724c <vector125>:
8010724c:	6a 00                	push   $0x0
8010724e:	6a 7d                	push   $0x7d
80107250:	e9 9a f6 ff ff       	jmp    801068ef <alltraps>

80107255 <vector126>:
80107255:	6a 00                	push   $0x0
80107257:	6a 7e                	push   $0x7e
80107259:	e9 91 f6 ff ff       	jmp    801068ef <alltraps>

8010725e <vector127>:
8010725e:	6a 00                	push   $0x0
80107260:	6a 7f                	push   $0x7f
80107262:	e9 88 f6 ff ff       	jmp    801068ef <alltraps>

80107267 <vector128>:
80107267:	6a 00                	push   $0x0
80107269:	68 80 00 00 00       	push   $0x80
8010726e:	e9 7c f6 ff ff       	jmp    801068ef <alltraps>

80107273 <vector129>:
80107273:	6a 00                	push   $0x0
80107275:	68 81 00 00 00       	push   $0x81
8010727a:	e9 70 f6 ff ff       	jmp    801068ef <alltraps>

8010727f <vector130>:
8010727f:	6a 00                	push   $0x0
80107281:	68 82 00 00 00       	push   $0x82
80107286:	e9 64 f6 ff ff       	jmp    801068ef <alltraps>

8010728b <vector131>:
8010728b:	6a 00                	push   $0x0
8010728d:	68 83 00 00 00       	push   $0x83
80107292:	e9 58 f6 ff ff       	jmp    801068ef <alltraps>

80107297 <vector132>:
80107297:	6a 00                	push   $0x0
80107299:	68 84 00 00 00       	push   $0x84
8010729e:	e9 4c f6 ff ff       	jmp    801068ef <alltraps>

801072a3 <vector133>:
801072a3:	6a 00                	push   $0x0
801072a5:	68 85 00 00 00       	push   $0x85
801072aa:	e9 40 f6 ff ff       	jmp    801068ef <alltraps>

801072af <vector134>:
801072af:	6a 00                	push   $0x0
801072b1:	68 86 00 00 00       	push   $0x86
801072b6:	e9 34 f6 ff ff       	jmp    801068ef <alltraps>

801072bb <vector135>:
801072bb:	6a 00                	push   $0x0
801072bd:	68 87 00 00 00       	push   $0x87
801072c2:	e9 28 f6 ff ff       	jmp    801068ef <alltraps>

801072c7 <vector136>:
801072c7:	6a 00                	push   $0x0
801072c9:	68 88 00 00 00       	push   $0x88
801072ce:	e9 1c f6 ff ff       	jmp    801068ef <alltraps>

801072d3 <vector137>:
801072d3:	6a 00                	push   $0x0
801072d5:	68 89 00 00 00       	push   $0x89
801072da:	e9 10 f6 ff ff       	jmp    801068ef <alltraps>

801072df <vector138>:
801072df:	6a 00                	push   $0x0
801072e1:	68 8a 00 00 00       	push   $0x8a
801072e6:	e9 04 f6 ff ff       	jmp    801068ef <alltraps>

801072eb <vector139>:
801072eb:	6a 00                	push   $0x0
801072ed:	68 8b 00 00 00       	push   $0x8b
801072f2:	e9 f8 f5 ff ff       	jmp    801068ef <alltraps>

801072f7 <vector140>:
801072f7:	6a 00                	push   $0x0
801072f9:	68 8c 00 00 00       	push   $0x8c
801072fe:	e9 ec f5 ff ff       	jmp    801068ef <alltraps>

80107303 <vector141>:
80107303:	6a 00                	push   $0x0
80107305:	68 8d 00 00 00       	push   $0x8d
8010730a:	e9 e0 f5 ff ff       	jmp    801068ef <alltraps>

8010730f <vector142>:
8010730f:	6a 00                	push   $0x0
80107311:	68 8e 00 00 00       	push   $0x8e
80107316:	e9 d4 f5 ff ff       	jmp    801068ef <alltraps>

8010731b <vector143>:
8010731b:	6a 00                	push   $0x0
8010731d:	68 8f 00 00 00       	push   $0x8f
80107322:	e9 c8 f5 ff ff       	jmp    801068ef <alltraps>

80107327 <vector144>:
80107327:	6a 00                	push   $0x0
80107329:	68 90 00 00 00       	push   $0x90
8010732e:	e9 bc f5 ff ff       	jmp    801068ef <alltraps>

80107333 <vector145>:
80107333:	6a 00                	push   $0x0
80107335:	68 91 00 00 00       	push   $0x91
8010733a:	e9 b0 f5 ff ff       	jmp    801068ef <alltraps>

8010733f <vector146>:
8010733f:	6a 00                	push   $0x0
80107341:	68 92 00 00 00       	push   $0x92
80107346:	e9 a4 f5 ff ff       	jmp    801068ef <alltraps>

8010734b <vector147>:
8010734b:	6a 00                	push   $0x0
8010734d:	68 93 00 00 00       	push   $0x93
80107352:	e9 98 f5 ff ff       	jmp    801068ef <alltraps>

80107357 <vector148>:
80107357:	6a 00                	push   $0x0
80107359:	68 94 00 00 00       	push   $0x94
8010735e:	e9 8c f5 ff ff       	jmp    801068ef <alltraps>

80107363 <vector149>:
80107363:	6a 00                	push   $0x0
80107365:	68 95 00 00 00       	push   $0x95
8010736a:	e9 80 f5 ff ff       	jmp    801068ef <alltraps>

8010736f <vector150>:
8010736f:	6a 00                	push   $0x0
80107371:	68 96 00 00 00       	push   $0x96
80107376:	e9 74 f5 ff ff       	jmp    801068ef <alltraps>

8010737b <vector151>:
8010737b:	6a 00                	push   $0x0
8010737d:	68 97 00 00 00       	push   $0x97
80107382:	e9 68 f5 ff ff       	jmp    801068ef <alltraps>

80107387 <vector152>:
80107387:	6a 00                	push   $0x0
80107389:	68 98 00 00 00       	push   $0x98
8010738e:	e9 5c f5 ff ff       	jmp    801068ef <alltraps>

80107393 <vector153>:
80107393:	6a 00                	push   $0x0
80107395:	68 99 00 00 00       	push   $0x99
8010739a:	e9 50 f5 ff ff       	jmp    801068ef <alltraps>

8010739f <vector154>:
8010739f:	6a 00                	push   $0x0
801073a1:	68 9a 00 00 00       	push   $0x9a
801073a6:	e9 44 f5 ff ff       	jmp    801068ef <alltraps>

801073ab <vector155>:
801073ab:	6a 00                	push   $0x0
801073ad:	68 9b 00 00 00       	push   $0x9b
801073b2:	e9 38 f5 ff ff       	jmp    801068ef <alltraps>

801073b7 <vector156>:
801073b7:	6a 00                	push   $0x0
801073b9:	68 9c 00 00 00       	push   $0x9c
801073be:	e9 2c f5 ff ff       	jmp    801068ef <alltraps>

801073c3 <vector157>:
801073c3:	6a 00                	push   $0x0
801073c5:	68 9d 00 00 00       	push   $0x9d
801073ca:	e9 20 f5 ff ff       	jmp    801068ef <alltraps>

801073cf <vector158>:
801073cf:	6a 00                	push   $0x0
801073d1:	68 9e 00 00 00       	push   $0x9e
801073d6:	e9 14 f5 ff ff       	jmp    801068ef <alltraps>

801073db <vector159>:
801073db:	6a 00                	push   $0x0
801073dd:	68 9f 00 00 00       	push   $0x9f
801073e2:	e9 08 f5 ff ff       	jmp    801068ef <alltraps>

801073e7 <vector160>:
801073e7:	6a 00                	push   $0x0
801073e9:	68 a0 00 00 00       	push   $0xa0
801073ee:	e9 fc f4 ff ff       	jmp    801068ef <alltraps>

801073f3 <vector161>:
801073f3:	6a 00                	push   $0x0
801073f5:	68 a1 00 00 00       	push   $0xa1
801073fa:	e9 f0 f4 ff ff       	jmp    801068ef <alltraps>

801073ff <vector162>:
801073ff:	6a 00                	push   $0x0
80107401:	68 a2 00 00 00       	push   $0xa2
80107406:	e9 e4 f4 ff ff       	jmp    801068ef <alltraps>

8010740b <vector163>:
8010740b:	6a 00                	push   $0x0
8010740d:	68 a3 00 00 00       	push   $0xa3
80107412:	e9 d8 f4 ff ff       	jmp    801068ef <alltraps>

80107417 <vector164>:
80107417:	6a 00                	push   $0x0
80107419:	68 a4 00 00 00       	push   $0xa4
8010741e:	e9 cc f4 ff ff       	jmp    801068ef <alltraps>

80107423 <vector165>:
80107423:	6a 00                	push   $0x0
80107425:	68 a5 00 00 00       	push   $0xa5
8010742a:	e9 c0 f4 ff ff       	jmp    801068ef <alltraps>

8010742f <vector166>:
8010742f:	6a 00                	push   $0x0
80107431:	68 a6 00 00 00       	push   $0xa6
80107436:	e9 b4 f4 ff ff       	jmp    801068ef <alltraps>

8010743b <vector167>:
8010743b:	6a 00                	push   $0x0
8010743d:	68 a7 00 00 00       	push   $0xa7
80107442:	e9 a8 f4 ff ff       	jmp    801068ef <alltraps>

80107447 <vector168>:
80107447:	6a 00                	push   $0x0
80107449:	68 a8 00 00 00       	push   $0xa8
8010744e:	e9 9c f4 ff ff       	jmp    801068ef <alltraps>

80107453 <vector169>:
80107453:	6a 00                	push   $0x0
80107455:	68 a9 00 00 00       	push   $0xa9
8010745a:	e9 90 f4 ff ff       	jmp    801068ef <alltraps>

8010745f <vector170>:
8010745f:	6a 00                	push   $0x0
80107461:	68 aa 00 00 00       	push   $0xaa
80107466:	e9 84 f4 ff ff       	jmp    801068ef <alltraps>

8010746b <vector171>:
8010746b:	6a 00                	push   $0x0
8010746d:	68 ab 00 00 00       	push   $0xab
80107472:	e9 78 f4 ff ff       	jmp    801068ef <alltraps>

80107477 <vector172>:
80107477:	6a 00                	push   $0x0
80107479:	68 ac 00 00 00       	push   $0xac
8010747e:	e9 6c f4 ff ff       	jmp    801068ef <alltraps>

80107483 <vector173>:
80107483:	6a 00                	push   $0x0
80107485:	68 ad 00 00 00       	push   $0xad
8010748a:	e9 60 f4 ff ff       	jmp    801068ef <alltraps>

8010748f <vector174>:
8010748f:	6a 00                	push   $0x0
80107491:	68 ae 00 00 00       	push   $0xae
80107496:	e9 54 f4 ff ff       	jmp    801068ef <alltraps>

8010749b <vector175>:
8010749b:	6a 00                	push   $0x0
8010749d:	68 af 00 00 00       	push   $0xaf
801074a2:	e9 48 f4 ff ff       	jmp    801068ef <alltraps>

801074a7 <vector176>:
801074a7:	6a 00                	push   $0x0
801074a9:	68 b0 00 00 00       	push   $0xb0
801074ae:	e9 3c f4 ff ff       	jmp    801068ef <alltraps>

801074b3 <vector177>:
801074b3:	6a 00                	push   $0x0
801074b5:	68 b1 00 00 00       	push   $0xb1
801074ba:	e9 30 f4 ff ff       	jmp    801068ef <alltraps>

801074bf <vector178>:
801074bf:	6a 00                	push   $0x0
801074c1:	68 b2 00 00 00       	push   $0xb2
801074c6:	e9 24 f4 ff ff       	jmp    801068ef <alltraps>

801074cb <vector179>:
801074cb:	6a 00                	push   $0x0
801074cd:	68 b3 00 00 00       	push   $0xb3
801074d2:	e9 18 f4 ff ff       	jmp    801068ef <alltraps>

801074d7 <vector180>:
801074d7:	6a 00                	push   $0x0
801074d9:	68 b4 00 00 00       	push   $0xb4
801074de:	e9 0c f4 ff ff       	jmp    801068ef <alltraps>

801074e3 <vector181>:
801074e3:	6a 00                	push   $0x0
801074e5:	68 b5 00 00 00       	push   $0xb5
801074ea:	e9 00 f4 ff ff       	jmp    801068ef <alltraps>

801074ef <vector182>:
801074ef:	6a 00                	push   $0x0
801074f1:	68 b6 00 00 00       	push   $0xb6
801074f6:	e9 f4 f3 ff ff       	jmp    801068ef <alltraps>

801074fb <vector183>:
801074fb:	6a 00                	push   $0x0
801074fd:	68 b7 00 00 00       	push   $0xb7
80107502:	e9 e8 f3 ff ff       	jmp    801068ef <alltraps>

80107507 <vector184>:
80107507:	6a 00                	push   $0x0
80107509:	68 b8 00 00 00       	push   $0xb8
8010750e:	e9 dc f3 ff ff       	jmp    801068ef <alltraps>

80107513 <vector185>:
80107513:	6a 00                	push   $0x0
80107515:	68 b9 00 00 00       	push   $0xb9
8010751a:	e9 d0 f3 ff ff       	jmp    801068ef <alltraps>

8010751f <vector186>:
8010751f:	6a 00                	push   $0x0
80107521:	68 ba 00 00 00       	push   $0xba
80107526:	e9 c4 f3 ff ff       	jmp    801068ef <alltraps>

8010752b <vector187>:
8010752b:	6a 00                	push   $0x0
8010752d:	68 bb 00 00 00       	push   $0xbb
80107532:	e9 b8 f3 ff ff       	jmp    801068ef <alltraps>

80107537 <vector188>:
80107537:	6a 00                	push   $0x0
80107539:	68 bc 00 00 00       	push   $0xbc
8010753e:	e9 ac f3 ff ff       	jmp    801068ef <alltraps>

80107543 <vector189>:
80107543:	6a 00                	push   $0x0
80107545:	68 bd 00 00 00       	push   $0xbd
8010754a:	e9 a0 f3 ff ff       	jmp    801068ef <alltraps>

8010754f <vector190>:
8010754f:	6a 00                	push   $0x0
80107551:	68 be 00 00 00       	push   $0xbe
80107556:	e9 94 f3 ff ff       	jmp    801068ef <alltraps>

8010755b <vector191>:
8010755b:	6a 00                	push   $0x0
8010755d:	68 bf 00 00 00       	push   $0xbf
80107562:	e9 88 f3 ff ff       	jmp    801068ef <alltraps>

80107567 <vector192>:
80107567:	6a 00                	push   $0x0
80107569:	68 c0 00 00 00       	push   $0xc0
8010756e:	e9 7c f3 ff ff       	jmp    801068ef <alltraps>

80107573 <vector193>:
80107573:	6a 00                	push   $0x0
80107575:	68 c1 00 00 00       	push   $0xc1
8010757a:	e9 70 f3 ff ff       	jmp    801068ef <alltraps>

8010757f <vector194>:
8010757f:	6a 00                	push   $0x0
80107581:	68 c2 00 00 00       	push   $0xc2
80107586:	e9 64 f3 ff ff       	jmp    801068ef <alltraps>

8010758b <vector195>:
8010758b:	6a 00                	push   $0x0
8010758d:	68 c3 00 00 00       	push   $0xc3
80107592:	e9 58 f3 ff ff       	jmp    801068ef <alltraps>

80107597 <vector196>:
80107597:	6a 00                	push   $0x0
80107599:	68 c4 00 00 00       	push   $0xc4
8010759e:	e9 4c f3 ff ff       	jmp    801068ef <alltraps>

801075a3 <vector197>:
801075a3:	6a 00                	push   $0x0
801075a5:	68 c5 00 00 00       	push   $0xc5
801075aa:	e9 40 f3 ff ff       	jmp    801068ef <alltraps>

801075af <vector198>:
801075af:	6a 00                	push   $0x0
801075b1:	68 c6 00 00 00       	push   $0xc6
801075b6:	e9 34 f3 ff ff       	jmp    801068ef <alltraps>

801075bb <vector199>:
801075bb:	6a 00                	push   $0x0
801075bd:	68 c7 00 00 00       	push   $0xc7
801075c2:	e9 28 f3 ff ff       	jmp    801068ef <alltraps>

801075c7 <vector200>:
801075c7:	6a 00                	push   $0x0
801075c9:	68 c8 00 00 00       	push   $0xc8
801075ce:	e9 1c f3 ff ff       	jmp    801068ef <alltraps>

801075d3 <vector201>:
801075d3:	6a 00                	push   $0x0
801075d5:	68 c9 00 00 00       	push   $0xc9
801075da:	e9 10 f3 ff ff       	jmp    801068ef <alltraps>

801075df <vector202>:
801075df:	6a 00                	push   $0x0
801075e1:	68 ca 00 00 00       	push   $0xca
801075e6:	e9 04 f3 ff ff       	jmp    801068ef <alltraps>

801075eb <vector203>:
801075eb:	6a 00                	push   $0x0
801075ed:	68 cb 00 00 00       	push   $0xcb
801075f2:	e9 f8 f2 ff ff       	jmp    801068ef <alltraps>

801075f7 <vector204>:
801075f7:	6a 00                	push   $0x0
801075f9:	68 cc 00 00 00       	push   $0xcc
801075fe:	e9 ec f2 ff ff       	jmp    801068ef <alltraps>

80107603 <vector205>:
80107603:	6a 00                	push   $0x0
80107605:	68 cd 00 00 00       	push   $0xcd
8010760a:	e9 e0 f2 ff ff       	jmp    801068ef <alltraps>

8010760f <vector206>:
8010760f:	6a 00                	push   $0x0
80107611:	68 ce 00 00 00       	push   $0xce
80107616:	e9 d4 f2 ff ff       	jmp    801068ef <alltraps>

8010761b <vector207>:
8010761b:	6a 00                	push   $0x0
8010761d:	68 cf 00 00 00       	push   $0xcf
80107622:	e9 c8 f2 ff ff       	jmp    801068ef <alltraps>

80107627 <vector208>:
80107627:	6a 00                	push   $0x0
80107629:	68 d0 00 00 00       	push   $0xd0
8010762e:	e9 bc f2 ff ff       	jmp    801068ef <alltraps>

80107633 <vector209>:
80107633:	6a 00                	push   $0x0
80107635:	68 d1 00 00 00       	push   $0xd1
8010763a:	e9 b0 f2 ff ff       	jmp    801068ef <alltraps>

8010763f <vector210>:
8010763f:	6a 00                	push   $0x0
80107641:	68 d2 00 00 00       	push   $0xd2
80107646:	e9 a4 f2 ff ff       	jmp    801068ef <alltraps>

8010764b <vector211>:
8010764b:	6a 00                	push   $0x0
8010764d:	68 d3 00 00 00       	push   $0xd3
80107652:	e9 98 f2 ff ff       	jmp    801068ef <alltraps>

80107657 <vector212>:
80107657:	6a 00                	push   $0x0
80107659:	68 d4 00 00 00       	push   $0xd4
8010765e:	e9 8c f2 ff ff       	jmp    801068ef <alltraps>

80107663 <vector213>:
80107663:	6a 00                	push   $0x0
80107665:	68 d5 00 00 00       	push   $0xd5
8010766a:	e9 80 f2 ff ff       	jmp    801068ef <alltraps>

8010766f <vector214>:
8010766f:	6a 00                	push   $0x0
80107671:	68 d6 00 00 00       	push   $0xd6
80107676:	e9 74 f2 ff ff       	jmp    801068ef <alltraps>

8010767b <vector215>:
8010767b:	6a 00                	push   $0x0
8010767d:	68 d7 00 00 00       	push   $0xd7
80107682:	e9 68 f2 ff ff       	jmp    801068ef <alltraps>

80107687 <vector216>:
80107687:	6a 00                	push   $0x0
80107689:	68 d8 00 00 00       	push   $0xd8
8010768e:	e9 5c f2 ff ff       	jmp    801068ef <alltraps>

80107693 <vector217>:
80107693:	6a 00                	push   $0x0
80107695:	68 d9 00 00 00       	push   $0xd9
8010769a:	e9 50 f2 ff ff       	jmp    801068ef <alltraps>

8010769f <vector218>:
8010769f:	6a 00                	push   $0x0
801076a1:	68 da 00 00 00       	push   $0xda
801076a6:	e9 44 f2 ff ff       	jmp    801068ef <alltraps>

801076ab <vector219>:
801076ab:	6a 00                	push   $0x0
801076ad:	68 db 00 00 00       	push   $0xdb
801076b2:	e9 38 f2 ff ff       	jmp    801068ef <alltraps>

801076b7 <vector220>:
801076b7:	6a 00                	push   $0x0
801076b9:	68 dc 00 00 00       	push   $0xdc
801076be:	e9 2c f2 ff ff       	jmp    801068ef <alltraps>

801076c3 <vector221>:
801076c3:	6a 00                	push   $0x0
801076c5:	68 dd 00 00 00       	push   $0xdd
801076ca:	e9 20 f2 ff ff       	jmp    801068ef <alltraps>

801076cf <vector222>:
801076cf:	6a 00                	push   $0x0
801076d1:	68 de 00 00 00       	push   $0xde
801076d6:	e9 14 f2 ff ff       	jmp    801068ef <alltraps>

801076db <vector223>:
801076db:	6a 00                	push   $0x0
801076dd:	68 df 00 00 00       	push   $0xdf
801076e2:	e9 08 f2 ff ff       	jmp    801068ef <alltraps>

801076e7 <vector224>:
801076e7:	6a 00                	push   $0x0
801076e9:	68 e0 00 00 00       	push   $0xe0
801076ee:	e9 fc f1 ff ff       	jmp    801068ef <alltraps>

801076f3 <vector225>:
801076f3:	6a 00                	push   $0x0
801076f5:	68 e1 00 00 00       	push   $0xe1
801076fa:	e9 f0 f1 ff ff       	jmp    801068ef <alltraps>

801076ff <vector226>:
801076ff:	6a 00                	push   $0x0
80107701:	68 e2 00 00 00       	push   $0xe2
80107706:	e9 e4 f1 ff ff       	jmp    801068ef <alltraps>

8010770b <vector227>:
8010770b:	6a 00                	push   $0x0
8010770d:	68 e3 00 00 00       	push   $0xe3
80107712:	e9 d8 f1 ff ff       	jmp    801068ef <alltraps>

80107717 <vector228>:
80107717:	6a 00                	push   $0x0
80107719:	68 e4 00 00 00       	push   $0xe4
8010771e:	e9 cc f1 ff ff       	jmp    801068ef <alltraps>

80107723 <vector229>:
80107723:	6a 00                	push   $0x0
80107725:	68 e5 00 00 00       	push   $0xe5
8010772a:	e9 c0 f1 ff ff       	jmp    801068ef <alltraps>

8010772f <vector230>:
8010772f:	6a 00                	push   $0x0
80107731:	68 e6 00 00 00       	push   $0xe6
80107736:	e9 b4 f1 ff ff       	jmp    801068ef <alltraps>

8010773b <vector231>:
8010773b:	6a 00                	push   $0x0
8010773d:	68 e7 00 00 00       	push   $0xe7
80107742:	e9 a8 f1 ff ff       	jmp    801068ef <alltraps>

80107747 <vector232>:
80107747:	6a 00                	push   $0x0
80107749:	68 e8 00 00 00       	push   $0xe8
8010774e:	e9 9c f1 ff ff       	jmp    801068ef <alltraps>

80107753 <vector233>:
80107753:	6a 00                	push   $0x0
80107755:	68 e9 00 00 00       	push   $0xe9
8010775a:	e9 90 f1 ff ff       	jmp    801068ef <alltraps>

8010775f <vector234>:
8010775f:	6a 00                	push   $0x0
80107761:	68 ea 00 00 00       	push   $0xea
80107766:	e9 84 f1 ff ff       	jmp    801068ef <alltraps>

8010776b <vector235>:
8010776b:	6a 00                	push   $0x0
8010776d:	68 eb 00 00 00       	push   $0xeb
80107772:	e9 78 f1 ff ff       	jmp    801068ef <alltraps>

80107777 <vector236>:
80107777:	6a 00                	push   $0x0
80107779:	68 ec 00 00 00       	push   $0xec
8010777e:	e9 6c f1 ff ff       	jmp    801068ef <alltraps>

80107783 <vector237>:
80107783:	6a 00                	push   $0x0
80107785:	68 ed 00 00 00       	push   $0xed
8010778a:	e9 60 f1 ff ff       	jmp    801068ef <alltraps>

8010778f <vector238>:
8010778f:	6a 00                	push   $0x0
80107791:	68 ee 00 00 00       	push   $0xee
80107796:	e9 54 f1 ff ff       	jmp    801068ef <alltraps>

8010779b <vector239>:
8010779b:	6a 00                	push   $0x0
8010779d:	68 ef 00 00 00       	push   $0xef
801077a2:	e9 48 f1 ff ff       	jmp    801068ef <alltraps>

801077a7 <vector240>:
801077a7:	6a 00                	push   $0x0
801077a9:	68 f0 00 00 00       	push   $0xf0
801077ae:	e9 3c f1 ff ff       	jmp    801068ef <alltraps>

801077b3 <vector241>:
801077b3:	6a 00                	push   $0x0
801077b5:	68 f1 00 00 00       	push   $0xf1
801077ba:	e9 30 f1 ff ff       	jmp    801068ef <alltraps>

801077bf <vector242>:
801077bf:	6a 00                	push   $0x0
801077c1:	68 f2 00 00 00       	push   $0xf2
801077c6:	e9 24 f1 ff ff       	jmp    801068ef <alltraps>

801077cb <vector243>:
801077cb:	6a 00                	push   $0x0
801077cd:	68 f3 00 00 00       	push   $0xf3
801077d2:	e9 18 f1 ff ff       	jmp    801068ef <alltraps>

801077d7 <vector244>:
801077d7:	6a 00                	push   $0x0
801077d9:	68 f4 00 00 00       	push   $0xf4
801077de:	e9 0c f1 ff ff       	jmp    801068ef <alltraps>

801077e3 <vector245>:
801077e3:	6a 00                	push   $0x0
801077e5:	68 f5 00 00 00       	push   $0xf5
801077ea:	e9 00 f1 ff ff       	jmp    801068ef <alltraps>

801077ef <vector246>:
801077ef:	6a 00                	push   $0x0
801077f1:	68 f6 00 00 00       	push   $0xf6
801077f6:	e9 f4 f0 ff ff       	jmp    801068ef <alltraps>

801077fb <vector247>:
801077fb:	6a 00                	push   $0x0
801077fd:	68 f7 00 00 00       	push   $0xf7
80107802:	e9 e8 f0 ff ff       	jmp    801068ef <alltraps>

80107807 <vector248>:
80107807:	6a 00                	push   $0x0
80107809:	68 f8 00 00 00       	push   $0xf8
8010780e:	e9 dc f0 ff ff       	jmp    801068ef <alltraps>

80107813 <vector249>:
80107813:	6a 00                	push   $0x0
80107815:	68 f9 00 00 00       	push   $0xf9
8010781a:	e9 d0 f0 ff ff       	jmp    801068ef <alltraps>

8010781f <vector250>:
8010781f:	6a 00                	push   $0x0
80107821:	68 fa 00 00 00       	push   $0xfa
80107826:	e9 c4 f0 ff ff       	jmp    801068ef <alltraps>

8010782b <vector251>:
8010782b:	6a 00                	push   $0x0
8010782d:	68 fb 00 00 00       	push   $0xfb
80107832:	e9 b8 f0 ff ff       	jmp    801068ef <alltraps>

80107837 <vector252>:
80107837:	6a 00                	push   $0x0
80107839:	68 fc 00 00 00       	push   $0xfc
8010783e:	e9 ac f0 ff ff       	jmp    801068ef <alltraps>

80107843 <vector253>:
80107843:	6a 00                	push   $0x0
80107845:	68 fd 00 00 00       	push   $0xfd
8010784a:	e9 a0 f0 ff ff       	jmp    801068ef <alltraps>

8010784f <vector254>:
8010784f:	6a 00                	push   $0x0
80107851:	68 fe 00 00 00       	push   $0xfe
80107856:	e9 94 f0 ff ff       	jmp    801068ef <alltraps>

8010785b <vector255>:
8010785b:	6a 00                	push   $0x0
8010785d:	68 ff 00 00 00       	push   $0xff
80107862:	e9 88 f0 ff ff       	jmp    801068ef <alltraps>
80107867:	66 90                	xchg   %ax,%ax
80107869:	66 90                	xchg   %ax,%ax
8010786b:	66 90                	xchg   %ax,%ax
8010786d:	66 90                	xchg   %ax,%ax
8010786f:	90                   	nop

80107870 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107870:	55                   	push   %ebp
80107871:	89 e5                	mov    %esp,%ebp
80107873:	57                   	push   %edi
80107874:	56                   	push   %esi
80107875:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80107876:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
8010787c:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107882:	83 ec 1c             	sub    $0x1c,%esp
80107885:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80107888:	39 d3                	cmp    %edx,%ebx
8010788a:	73 49                	jae    801078d5 <deallocuvm.part.0+0x65>
8010788c:	89 c7                	mov    %eax,%edi
8010788e:	eb 0c                	jmp    8010789c <deallocuvm.part.0+0x2c>
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80107890:	83 c0 01             	add    $0x1,%eax
80107893:	c1 e0 16             	shl    $0x16,%eax
80107896:	89 c3                	mov    %eax,%ebx
  for(; a  < oldsz; a += PGSIZE){
80107898:	39 da                	cmp    %ebx,%edx
8010789a:	76 39                	jbe    801078d5 <deallocuvm.part.0+0x65>
  pde = &pgdir[PDX(va)];
8010789c:	89 d8                	mov    %ebx,%eax
8010789e:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
801078a1:	8b 0c 87             	mov    (%edi,%eax,4),%ecx
801078a4:	f6 c1 01             	test   $0x1,%cl
801078a7:	74 e7                	je     80107890 <deallocuvm.part.0+0x20>
  return &pgtab[PTX(va)];
801078a9:	89 de                	mov    %ebx,%esi
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801078ab:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
801078b1:	c1 ee 0a             	shr    $0xa,%esi
801078b4:	81 e6 fc 0f 00 00    	and    $0xffc,%esi
801078ba:	8d b4 31 00 00 00 80 	lea    -0x80000000(%ecx,%esi,1),%esi
    if(!pte)
801078c1:	85 f6                	test   %esi,%esi
801078c3:	74 cb                	je     80107890 <deallocuvm.part.0+0x20>
    else if((*pte & PTE_P) != 0){
801078c5:	8b 06                	mov    (%esi),%eax
801078c7:	a8 01                	test   $0x1,%al
801078c9:	75 15                	jne    801078e0 <deallocuvm.part.0+0x70>
  for(; a  < oldsz; a += PGSIZE){
801078cb:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801078d1:	39 da                	cmp    %ebx,%edx
801078d3:	77 c7                	ja     8010789c <deallocuvm.part.0+0x2c>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
801078d5:	8b 45 e0             	mov    -0x20(%ebp),%eax
801078d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801078db:	5b                   	pop    %ebx
801078dc:	5e                   	pop    %esi
801078dd:	5f                   	pop    %edi
801078de:	5d                   	pop    %ebp
801078df:	c3                   	ret    
      if(pa == 0)
801078e0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801078e5:	74 25                	je     8010790c <deallocuvm.part.0+0x9c>
      kfree(v);
801078e7:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
801078ea:	05 00 00 00 80       	add    $0x80000000,%eax
801078ef:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
801078f2:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      kfree(v);
801078f8:	50                   	push   %eax
801078f9:	e8 f2 b7 ff ff       	call   801030f0 <kfree>
      *pte = 0;
801078fe:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  for(; a  < oldsz; a += PGSIZE){
80107904:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107907:	83 c4 10             	add    $0x10,%esp
8010790a:	eb 8c                	jmp    80107898 <deallocuvm.part.0+0x28>
        panic("kfree");
8010790c:	83 ec 0c             	sub    $0xc,%esp
8010790f:	68 c6 84 10 80       	push   $0x801084c6
80107914:	e8 67 8a ff ff       	call   80100380 <panic>
80107919:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107920 <mappages>:
{
80107920:	55                   	push   %ebp
80107921:	89 e5                	mov    %esp,%ebp
80107923:	57                   	push   %edi
80107924:	56                   	push   %esi
80107925:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80107926:	89 d3                	mov    %edx,%ebx
80107928:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
8010792e:	83 ec 1c             	sub    $0x1c,%esp
80107931:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107934:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80107938:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010793d:	89 45 dc             	mov    %eax,-0x24(%ebp)
80107940:	8b 45 08             	mov    0x8(%ebp),%eax
80107943:	29 d8                	sub    %ebx,%eax
80107945:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107948:	eb 3d                	jmp    80107987 <mappages+0x67>
8010794a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80107950:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107952:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107957:	c1 ea 0a             	shr    $0xa,%edx
8010795a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107960:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107967:	85 c0                	test   %eax,%eax
80107969:	74 75                	je     801079e0 <mappages+0xc0>
    if(*pte & PTE_P)
8010796b:	f6 00 01             	testb  $0x1,(%eax)
8010796e:	0f 85 86 00 00 00    	jne    801079fa <mappages+0xda>
    *pte = pa | perm | PTE_P;
80107974:	0b 75 0c             	or     0xc(%ebp),%esi
80107977:	83 ce 01             	or     $0x1,%esi
8010797a:	89 30                	mov    %esi,(%eax)
    if(a == last)
8010797c:	3b 5d dc             	cmp    -0x24(%ebp),%ebx
8010797f:	74 6f                	je     801079f0 <mappages+0xd0>
    a += PGSIZE;
80107981:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(;;){
80107987:	8b 45 e0             	mov    -0x20(%ebp),%eax
  pde = &pgdir[PDX(va)];
8010798a:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010798d:	8d 34 18             	lea    (%eax,%ebx,1),%esi
80107990:	89 d8                	mov    %ebx,%eax
80107992:	c1 e8 16             	shr    $0x16,%eax
80107995:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
80107998:	8b 07                	mov    (%edi),%eax
8010799a:	a8 01                	test   $0x1,%al
8010799c:	75 b2                	jne    80107950 <mappages+0x30>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
8010799e:	e8 0d b9 ff ff       	call   801032b0 <kalloc>
801079a3:	85 c0                	test   %eax,%eax
801079a5:	74 39                	je     801079e0 <mappages+0xc0>
    memset(pgtab, 0, PGSIZE);
801079a7:	83 ec 04             	sub    $0x4,%esp
801079aa:	89 45 d8             	mov    %eax,-0x28(%ebp)
801079ad:	68 00 10 00 00       	push   $0x1000
801079b2:	6a 00                	push   $0x0
801079b4:	50                   	push   %eax
801079b5:	e8 f6 db ff ff       	call   801055b0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801079ba:	8b 55 d8             	mov    -0x28(%ebp),%edx
  return &pgtab[PTX(va)];
801079bd:	83 c4 10             	add    $0x10,%esp
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801079c0:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
801079c6:	83 c8 07             	or     $0x7,%eax
801079c9:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
801079cb:	89 d8                	mov    %ebx,%eax
801079cd:	c1 e8 0a             	shr    $0xa,%eax
801079d0:	25 fc 0f 00 00       	and    $0xffc,%eax
801079d5:	01 d0                	add    %edx,%eax
801079d7:	eb 92                	jmp    8010796b <mappages+0x4b>
801079d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}
801079e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801079e3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801079e8:	5b                   	pop    %ebx
801079e9:	5e                   	pop    %esi
801079ea:	5f                   	pop    %edi
801079eb:	5d                   	pop    %ebp
801079ec:	c3                   	ret    
801079ed:	8d 76 00             	lea    0x0(%esi),%esi
801079f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801079f3:	31 c0                	xor    %eax,%eax
}
801079f5:	5b                   	pop    %ebx
801079f6:	5e                   	pop    %esi
801079f7:	5f                   	pop    %edi
801079f8:	5d                   	pop    %ebp
801079f9:	c3                   	ret    
      panic("remap");
801079fa:	83 ec 0c             	sub    $0xc,%esp
801079fd:	68 14 8d 10 80       	push   $0x80108d14
80107a02:	e8 79 89 ff ff       	call   80100380 <panic>
80107a07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107a0e:	66 90                	xchg   %ax,%ax

80107a10 <seginit>:
{
80107a10:	55                   	push   %ebp
80107a11:	89 e5                	mov    %esp,%ebp
80107a13:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80107a16:	e8 a5 cb ff ff       	call   801045c0 <cpuid>
  pd[0] = size-1;
80107a1b:	ba 2f 00 00 00       	mov    $0x2f,%edx
80107a20:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80107a26:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80107a2a:	c7 80 18 32 11 80 ff 	movl   $0xffff,-0x7feecde8(%eax)
80107a31:	ff 00 00 
80107a34:	c7 80 1c 32 11 80 00 	movl   $0xcf9a00,-0x7feecde4(%eax)
80107a3b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107a3e:	c7 80 20 32 11 80 ff 	movl   $0xffff,-0x7feecde0(%eax)
80107a45:	ff 00 00 
80107a48:	c7 80 24 32 11 80 00 	movl   $0xcf9200,-0x7feecddc(%eax)
80107a4f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107a52:	c7 80 28 32 11 80 ff 	movl   $0xffff,-0x7feecdd8(%eax)
80107a59:	ff 00 00 
80107a5c:	c7 80 2c 32 11 80 00 	movl   $0xcffa00,-0x7feecdd4(%eax)
80107a63:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107a66:	c7 80 30 32 11 80 ff 	movl   $0xffff,-0x7feecdd0(%eax)
80107a6d:	ff 00 00 
80107a70:	c7 80 34 32 11 80 00 	movl   $0xcff200,-0x7feecdcc(%eax)
80107a77:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
80107a7a:	05 10 32 11 80       	add    $0x80113210,%eax
  pd[1] = (uint)p;
80107a7f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80107a83:	c1 e8 10             	shr    $0x10,%eax
80107a86:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80107a8a:	8d 45 f2             	lea    -0xe(%ebp),%eax
80107a8d:	0f 01 10             	lgdtl  (%eax)
}
80107a90:	c9                   	leave  
80107a91:	c3                   	ret    
80107a92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107a99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107aa0 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107aa0:	a1 c4 65 11 80       	mov    0x801165c4,%eax
80107aa5:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107aaa:	0f 22 d8             	mov    %eax,%cr3
}
80107aad:	c3                   	ret    
80107aae:	66 90                	xchg   %ax,%ax

80107ab0 <switchuvm>:
{
80107ab0:	55                   	push   %ebp
80107ab1:	89 e5                	mov    %esp,%ebp
80107ab3:	57                   	push   %edi
80107ab4:	56                   	push   %esi
80107ab5:	53                   	push   %ebx
80107ab6:	83 ec 1c             	sub    $0x1c,%esp
80107ab9:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80107abc:	85 f6                	test   %esi,%esi
80107abe:	0f 84 cb 00 00 00    	je     80107b8f <switchuvm+0xdf>
  if(p->kstack == 0)
80107ac4:	8b 46 08             	mov    0x8(%esi),%eax
80107ac7:	85 c0                	test   %eax,%eax
80107ac9:	0f 84 da 00 00 00    	je     80107ba9 <switchuvm+0xf9>
  if(p->pgdir == 0)
80107acf:	8b 46 04             	mov    0x4(%esi),%eax
80107ad2:	85 c0                	test   %eax,%eax
80107ad4:	0f 84 c2 00 00 00    	je     80107b9c <switchuvm+0xec>
  pushcli();
80107ada:	e8 c1 d8 ff ff       	call   801053a0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80107adf:	e8 7c ca ff ff       	call   80104560 <mycpu>
80107ae4:	89 c3                	mov    %eax,%ebx
80107ae6:	e8 75 ca ff ff       	call   80104560 <mycpu>
80107aeb:	89 c7                	mov    %eax,%edi
80107aed:	e8 6e ca ff ff       	call   80104560 <mycpu>
80107af2:	83 c7 08             	add    $0x8,%edi
80107af5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107af8:	e8 63 ca ff ff       	call   80104560 <mycpu>
80107afd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107b00:	ba 67 00 00 00       	mov    $0x67,%edx
80107b05:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80107b0c:	83 c0 08             	add    $0x8,%eax
80107b0f:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107b16:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80107b1b:	83 c1 08             	add    $0x8,%ecx
80107b1e:	c1 e8 18             	shr    $0x18,%eax
80107b21:	c1 e9 10             	shr    $0x10,%ecx
80107b24:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
80107b2a:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80107b30:	b9 99 40 00 00       	mov    $0x4099,%ecx
80107b35:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80107b3c:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
80107b41:	e8 1a ca ff ff       	call   80104560 <mycpu>
80107b46:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80107b4d:	e8 0e ca ff ff       	call   80104560 <mycpu>
80107b52:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80107b56:	8b 5e 08             	mov    0x8(%esi),%ebx
80107b59:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107b5f:	e8 fc c9 ff ff       	call   80104560 <mycpu>
80107b64:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107b67:	e8 f4 c9 ff ff       	call   80104560 <mycpu>
80107b6c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80107b70:	b8 28 00 00 00       	mov    $0x28,%eax
80107b75:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80107b78:	8b 46 04             	mov    0x4(%esi),%eax
80107b7b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107b80:	0f 22 d8             	mov    %eax,%cr3
}
80107b83:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107b86:	5b                   	pop    %ebx
80107b87:	5e                   	pop    %esi
80107b88:	5f                   	pop    %edi
80107b89:	5d                   	pop    %ebp
  popcli();
80107b8a:	e9 61 d8 ff ff       	jmp    801053f0 <popcli>
    panic("switchuvm: no process");
80107b8f:	83 ec 0c             	sub    $0xc,%esp
80107b92:	68 1a 8d 10 80       	push   $0x80108d1a
80107b97:	e8 e4 87 ff ff       	call   80100380 <panic>
    panic("switchuvm: no pgdir");
80107b9c:	83 ec 0c             	sub    $0xc,%esp
80107b9f:	68 45 8d 10 80       	push   $0x80108d45
80107ba4:	e8 d7 87 ff ff       	call   80100380 <panic>
    panic("switchuvm: no kstack");
80107ba9:	83 ec 0c             	sub    $0xc,%esp
80107bac:	68 30 8d 10 80       	push   $0x80108d30
80107bb1:	e8 ca 87 ff ff       	call   80100380 <panic>
80107bb6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107bbd:	8d 76 00             	lea    0x0(%esi),%esi

80107bc0 <inituvm>:
{
80107bc0:	55                   	push   %ebp
80107bc1:	89 e5                	mov    %esp,%ebp
80107bc3:	57                   	push   %edi
80107bc4:	56                   	push   %esi
80107bc5:	53                   	push   %ebx
80107bc6:	83 ec 1c             	sub    $0x1c,%esp
80107bc9:	8b 45 0c             	mov    0xc(%ebp),%eax
80107bcc:	8b 75 10             	mov    0x10(%ebp),%esi
80107bcf:	8b 7d 08             	mov    0x8(%ebp),%edi
80107bd2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80107bd5:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80107bdb:	77 4b                	ja     80107c28 <inituvm+0x68>
  mem = kalloc();
80107bdd:	e8 ce b6 ff ff       	call   801032b0 <kalloc>
  memset(mem, 0, PGSIZE);
80107be2:	83 ec 04             	sub    $0x4,%esp
80107be5:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
80107bea:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80107bec:	6a 00                	push   $0x0
80107bee:	50                   	push   %eax
80107bef:	e8 bc d9 ff ff       	call   801055b0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107bf4:	58                   	pop    %eax
80107bf5:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107bfb:	5a                   	pop    %edx
80107bfc:	6a 06                	push   $0x6
80107bfe:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107c03:	31 d2                	xor    %edx,%edx
80107c05:	50                   	push   %eax
80107c06:	89 f8                	mov    %edi,%eax
80107c08:	e8 13 fd ff ff       	call   80107920 <mappages>
  memmove(mem, init, sz);
80107c0d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107c10:	89 75 10             	mov    %esi,0x10(%ebp)
80107c13:	83 c4 10             	add    $0x10,%esp
80107c16:	89 5d 08             	mov    %ebx,0x8(%ebp)
80107c19:	89 45 0c             	mov    %eax,0xc(%ebp)
}
80107c1c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107c1f:	5b                   	pop    %ebx
80107c20:	5e                   	pop    %esi
80107c21:	5f                   	pop    %edi
80107c22:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80107c23:	e9 28 da ff ff       	jmp    80105650 <memmove>
    panic("inituvm: more than a page");
80107c28:	83 ec 0c             	sub    $0xc,%esp
80107c2b:	68 59 8d 10 80       	push   $0x80108d59
80107c30:	e8 4b 87 ff ff       	call   80100380 <panic>
80107c35:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107c40 <loaduvm>:
{
80107c40:	55                   	push   %ebp
80107c41:	89 e5                	mov    %esp,%ebp
80107c43:	57                   	push   %edi
80107c44:	56                   	push   %esi
80107c45:	53                   	push   %ebx
80107c46:	83 ec 1c             	sub    $0x1c,%esp
80107c49:	8b 45 0c             	mov    0xc(%ebp),%eax
80107c4c:	8b 75 18             	mov    0x18(%ebp),%esi
  if((uint) addr % PGSIZE != 0)
80107c4f:	a9 ff 0f 00 00       	test   $0xfff,%eax
80107c54:	0f 85 bb 00 00 00    	jne    80107d15 <loaduvm+0xd5>
  for(i = 0; i < sz; i += PGSIZE){
80107c5a:	01 f0                	add    %esi,%eax
80107c5c:	89 f3                	mov    %esi,%ebx
80107c5e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107c61:	8b 45 14             	mov    0x14(%ebp),%eax
80107c64:	01 f0                	add    %esi,%eax
80107c66:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
80107c69:	85 f6                	test   %esi,%esi
80107c6b:	0f 84 87 00 00 00    	je     80107cf8 <loaduvm+0xb8>
80107c71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  pde = &pgdir[PDX(va)];
80107c78:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  if(*pde & PTE_P){
80107c7b:	8b 4d 08             	mov    0x8(%ebp),%ecx
80107c7e:	29 d8                	sub    %ebx,%eax
  pde = &pgdir[PDX(va)];
80107c80:	89 c2                	mov    %eax,%edx
80107c82:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
80107c85:	8b 14 91             	mov    (%ecx,%edx,4),%edx
80107c88:	f6 c2 01             	test   $0x1,%dl
80107c8b:	75 13                	jne    80107ca0 <loaduvm+0x60>
      panic("loaduvm: address should exist");
80107c8d:	83 ec 0c             	sub    $0xc,%esp
80107c90:	68 73 8d 10 80       	push   $0x80108d73
80107c95:	e8 e6 86 ff ff       	call   80100380 <panic>
80107c9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80107ca0:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107ca3:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80107ca9:	25 fc 0f 00 00       	and    $0xffc,%eax
80107cae:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107cb5:	85 c0                	test   %eax,%eax
80107cb7:	74 d4                	je     80107c8d <loaduvm+0x4d>
    pa = PTE_ADDR(*pte);
80107cb9:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107cbb:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    if(sz - i < PGSIZE)
80107cbe:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80107cc3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80107cc8:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
80107cce:	0f 46 fb             	cmovbe %ebx,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107cd1:	29 d9                	sub    %ebx,%ecx
80107cd3:	05 00 00 00 80       	add    $0x80000000,%eax
80107cd8:	57                   	push   %edi
80107cd9:	51                   	push   %ecx
80107cda:	50                   	push   %eax
80107cdb:	ff 75 10             	push   0x10(%ebp)
80107cde:	e8 dd a9 ff ff       	call   801026c0 <readi>
80107ce3:	83 c4 10             	add    $0x10,%esp
80107ce6:	39 f8                	cmp    %edi,%eax
80107ce8:	75 1e                	jne    80107d08 <loaduvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
80107cea:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
80107cf0:	89 f0                	mov    %esi,%eax
80107cf2:	29 d8                	sub    %ebx,%eax
80107cf4:	39 c6                	cmp    %eax,%esi
80107cf6:	77 80                	ja     80107c78 <loaduvm+0x38>
}
80107cf8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107cfb:	31 c0                	xor    %eax,%eax
}
80107cfd:	5b                   	pop    %ebx
80107cfe:	5e                   	pop    %esi
80107cff:	5f                   	pop    %edi
80107d00:	5d                   	pop    %ebp
80107d01:	c3                   	ret    
80107d02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107d08:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107d0b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107d10:	5b                   	pop    %ebx
80107d11:	5e                   	pop    %esi
80107d12:	5f                   	pop    %edi
80107d13:	5d                   	pop    %ebp
80107d14:	c3                   	ret    
    panic("loaduvm: addr must be page aligned");
80107d15:	83 ec 0c             	sub    $0xc,%esp
80107d18:	68 14 8e 10 80       	push   $0x80108e14
80107d1d:	e8 5e 86 ff ff       	call   80100380 <panic>
80107d22:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107d29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107d30 <allocuvm>:
{
80107d30:	55                   	push   %ebp
80107d31:	89 e5                	mov    %esp,%ebp
80107d33:	57                   	push   %edi
80107d34:	56                   	push   %esi
80107d35:	53                   	push   %ebx
80107d36:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80107d39:	8b 45 10             	mov    0x10(%ebp),%eax
{
80107d3c:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(newsz >= KERNBASE)
80107d3f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107d42:	85 c0                	test   %eax,%eax
80107d44:	0f 88 b6 00 00 00    	js     80107e00 <allocuvm+0xd0>
  if(newsz < oldsz)
80107d4a:	3b 45 0c             	cmp    0xc(%ebp),%eax
    return oldsz;
80107d4d:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(newsz < oldsz)
80107d50:	0f 82 9a 00 00 00    	jb     80107df0 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
80107d56:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
80107d5c:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
80107d62:	39 75 10             	cmp    %esi,0x10(%ebp)
80107d65:	77 44                	ja     80107dab <allocuvm+0x7b>
80107d67:	e9 87 00 00 00       	jmp    80107df3 <allocuvm+0xc3>
80107d6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    memset(mem, 0, PGSIZE);
80107d70:	83 ec 04             	sub    $0x4,%esp
80107d73:	68 00 10 00 00       	push   $0x1000
80107d78:	6a 00                	push   $0x0
80107d7a:	50                   	push   %eax
80107d7b:	e8 30 d8 ff ff       	call   801055b0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80107d80:	58                   	pop    %eax
80107d81:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107d87:	5a                   	pop    %edx
80107d88:	6a 06                	push   $0x6
80107d8a:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107d8f:	89 f2                	mov    %esi,%edx
80107d91:	50                   	push   %eax
80107d92:	89 f8                	mov    %edi,%eax
80107d94:	e8 87 fb ff ff       	call   80107920 <mappages>
80107d99:	83 c4 10             	add    $0x10,%esp
80107d9c:	85 c0                	test   %eax,%eax
80107d9e:	78 78                	js     80107e18 <allocuvm+0xe8>
  for(; a < newsz; a += PGSIZE){
80107da0:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107da6:	39 75 10             	cmp    %esi,0x10(%ebp)
80107da9:	76 48                	jbe    80107df3 <allocuvm+0xc3>
    mem = kalloc();
80107dab:	e8 00 b5 ff ff       	call   801032b0 <kalloc>
80107db0:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80107db2:	85 c0                	test   %eax,%eax
80107db4:	75 ba                	jne    80107d70 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80107db6:	83 ec 0c             	sub    $0xc,%esp
80107db9:	68 91 8d 10 80       	push   $0x80108d91
80107dbe:	e8 cd 89 ff ff       	call   80100790 <cprintf>
  if(newsz >= oldsz)
80107dc3:	8b 45 0c             	mov    0xc(%ebp),%eax
80107dc6:	83 c4 10             	add    $0x10,%esp
80107dc9:	39 45 10             	cmp    %eax,0x10(%ebp)
80107dcc:	74 32                	je     80107e00 <allocuvm+0xd0>
80107dce:	8b 55 10             	mov    0x10(%ebp),%edx
80107dd1:	89 c1                	mov    %eax,%ecx
80107dd3:	89 f8                	mov    %edi,%eax
80107dd5:	e8 96 fa ff ff       	call   80107870 <deallocuvm.part.0>
      return 0;
80107dda:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80107de1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107de4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107de7:	5b                   	pop    %ebx
80107de8:	5e                   	pop    %esi
80107de9:	5f                   	pop    %edi
80107dea:	5d                   	pop    %ebp
80107deb:	c3                   	ret    
80107dec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
80107df0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
}
80107df3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107df6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107df9:	5b                   	pop    %ebx
80107dfa:	5e                   	pop    %esi
80107dfb:	5f                   	pop    %edi
80107dfc:	5d                   	pop    %ebp
80107dfd:	c3                   	ret    
80107dfe:	66 90                	xchg   %ax,%ax
    return 0;
80107e00:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80107e07:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107e0a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107e0d:	5b                   	pop    %ebx
80107e0e:	5e                   	pop    %esi
80107e0f:	5f                   	pop    %edi
80107e10:	5d                   	pop    %ebp
80107e11:	c3                   	ret    
80107e12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80107e18:	83 ec 0c             	sub    $0xc,%esp
80107e1b:	68 a9 8d 10 80       	push   $0x80108da9
80107e20:	e8 6b 89 ff ff       	call   80100790 <cprintf>
  if(newsz >= oldsz)
80107e25:	8b 45 0c             	mov    0xc(%ebp),%eax
80107e28:	83 c4 10             	add    $0x10,%esp
80107e2b:	39 45 10             	cmp    %eax,0x10(%ebp)
80107e2e:	74 0c                	je     80107e3c <allocuvm+0x10c>
80107e30:	8b 55 10             	mov    0x10(%ebp),%edx
80107e33:	89 c1                	mov    %eax,%ecx
80107e35:	89 f8                	mov    %edi,%eax
80107e37:	e8 34 fa ff ff       	call   80107870 <deallocuvm.part.0>
      kfree(mem);
80107e3c:	83 ec 0c             	sub    $0xc,%esp
80107e3f:	53                   	push   %ebx
80107e40:	e8 ab b2 ff ff       	call   801030f0 <kfree>
      return 0;
80107e45:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80107e4c:	83 c4 10             	add    $0x10,%esp
}
80107e4f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107e52:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107e55:	5b                   	pop    %ebx
80107e56:	5e                   	pop    %esi
80107e57:	5f                   	pop    %edi
80107e58:	5d                   	pop    %ebp
80107e59:	c3                   	ret    
80107e5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107e60 <deallocuvm>:
{
80107e60:	55                   	push   %ebp
80107e61:	89 e5                	mov    %esp,%ebp
80107e63:	8b 55 0c             	mov    0xc(%ebp),%edx
80107e66:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107e69:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80107e6c:	39 d1                	cmp    %edx,%ecx
80107e6e:	73 10                	jae    80107e80 <deallocuvm+0x20>
}
80107e70:	5d                   	pop    %ebp
80107e71:	e9 fa f9 ff ff       	jmp    80107870 <deallocuvm.part.0>
80107e76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107e7d:	8d 76 00             	lea    0x0(%esi),%esi
80107e80:	89 d0                	mov    %edx,%eax
80107e82:	5d                   	pop    %ebp
80107e83:	c3                   	ret    
80107e84:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107e8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107e8f:	90                   	nop

80107e90 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107e90:	55                   	push   %ebp
80107e91:	89 e5                	mov    %esp,%ebp
80107e93:	57                   	push   %edi
80107e94:	56                   	push   %esi
80107e95:	53                   	push   %ebx
80107e96:	83 ec 0c             	sub    $0xc,%esp
80107e99:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80107e9c:	85 f6                	test   %esi,%esi
80107e9e:	74 59                	je     80107ef9 <freevm+0x69>
  if(newsz >= oldsz)
80107ea0:	31 c9                	xor    %ecx,%ecx
80107ea2:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107ea7:	89 f0                	mov    %esi,%eax
80107ea9:	89 f3                	mov    %esi,%ebx
80107eab:	e8 c0 f9 ff ff       	call   80107870 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107eb0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107eb6:	eb 0f                	jmp    80107ec7 <freevm+0x37>
80107eb8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107ebf:	90                   	nop
80107ec0:	83 c3 04             	add    $0x4,%ebx
80107ec3:	39 df                	cmp    %ebx,%edi
80107ec5:	74 23                	je     80107eea <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107ec7:	8b 03                	mov    (%ebx),%eax
80107ec9:	a8 01                	test   $0x1,%al
80107ecb:	74 f3                	je     80107ec0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107ecd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107ed2:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107ed5:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107ed8:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80107edd:	50                   	push   %eax
80107ede:	e8 0d b2 ff ff       	call   801030f0 <kfree>
80107ee3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107ee6:	39 df                	cmp    %ebx,%edi
80107ee8:	75 dd                	jne    80107ec7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80107eea:	89 75 08             	mov    %esi,0x8(%ebp)
}
80107eed:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107ef0:	5b                   	pop    %ebx
80107ef1:	5e                   	pop    %esi
80107ef2:	5f                   	pop    %edi
80107ef3:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107ef4:	e9 f7 b1 ff ff       	jmp    801030f0 <kfree>
    panic("freevm: no pgdir");
80107ef9:	83 ec 0c             	sub    $0xc,%esp
80107efc:	68 c5 8d 10 80       	push   $0x80108dc5
80107f01:	e8 7a 84 ff ff       	call   80100380 <panic>
80107f06:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107f0d:	8d 76 00             	lea    0x0(%esi),%esi

80107f10 <setupkvm>:
{
80107f10:	55                   	push   %ebp
80107f11:	89 e5                	mov    %esp,%ebp
80107f13:	56                   	push   %esi
80107f14:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80107f15:	e8 96 b3 ff ff       	call   801032b0 <kalloc>
80107f1a:	89 c6                	mov    %eax,%esi
80107f1c:	85 c0                	test   %eax,%eax
80107f1e:	74 42                	je     80107f62 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80107f20:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107f23:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
80107f28:	68 00 10 00 00       	push   $0x1000
80107f2d:	6a 00                	push   $0x0
80107f2f:	50                   	push   %eax
80107f30:	e8 7b d6 ff ff       	call   801055b0 <memset>
80107f35:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80107f38:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80107f3b:	83 ec 08             	sub    $0x8,%esp
80107f3e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107f41:	ff 73 0c             	push   0xc(%ebx)
80107f44:	8b 13                	mov    (%ebx),%edx
80107f46:	50                   	push   %eax
80107f47:	29 c1                	sub    %eax,%ecx
80107f49:	89 f0                	mov    %esi,%eax
80107f4b:	e8 d0 f9 ff ff       	call   80107920 <mappages>
80107f50:	83 c4 10             	add    $0x10,%esp
80107f53:	85 c0                	test   %eax,%eax
80107f55:	78 19                	js     80107f70 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107f57:	83 c3 10             	add    $0x10,%ebx
80107f5a:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107f60:	75 d6                	jne    80107f38 <setupkvm+0x28>
}
80107f62:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107f65:	89 f0                	mov    %esi,%eax
80107f67:	5b                   	pop    %ebx
80107f68:	5e                   	pop    %esi
80107f69:	5d                   	pop    %ebp
80107f6a:	c3                   	ret    
80107f6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107f6f:	90                   	nop
      freevm(pgdir);
80107f70:	83 ec 0c             	sub    $0xc,%esp
80107f73:	56                   	push   %esi
      return 0;
80107f74:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80107f76:	e8 15 ff ff ff       	call   80107e90 <freevm>
      return 0;
80107f7b:	83 c4 10             	add    $0x10,%esp
}
80107f7e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107f81:	89 f0                	mov    %esi,%eax
80107f83:	5b                   	pop    %ebx
80107f84:	5e                   	pop    %esi
80107f85:	5d                   	pop    %ebp
80107f86:	c3                   	ret    
80107f87:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107f8e:	66 90                	xchg   %ax,%ax

80107f90 <kvmalloc>:
{
80107f90:	55                   	push   %ebp
80107f91:	89 e5                	mov    %esp,%ebp
80107f93:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107f96:	e8 75 ff ff ff       	call   80107f10 <setupkvm>
80107f9b:	a3 c4 65 11 80       	mov    %eax,0x801165c4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107fa0:	05 00 00 00 80       	add    $0x80000000,%eax
80107fa5:	0f 22 d8             	mov    %eax,%cr3
}
80107fa8:	c9                   	leave  
80107fa9:	c3                   	ret    
80107faa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107fb0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107fb0:	55                   	push   %ebp
80107fb1:	89 e5                	mov    %esp,%ebp
80107fb3:	83 ec 08             	sub    $0x8,%esp
80107fb6:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107fb9:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80107fbc:	89 c1                	mov    %eax,%ecx
80107fbe:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80107fc1:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107fc4:	f6 c2 01             	test   $0x1,%dl
80107fc7:	75 17                	jne    80107fe0 <clearpteu+0x30>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80107fc9:	83 ec 0c             	sub    $0xc,%esp
80107fcc:	68 d6 8d 10 80       	push   $0x80108dd6
80107fd1:	e8 aa 83 ff ff       	call   80100380 <panic>
80107fd6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107fdd:	8d 76 00             	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80107fe0:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107fe3:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80107fe9:	25 fc 0f 00 00       	and    $0xffc,%eax
80107fee:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
80107ff5:	85 c0                	test   %eax,%eax
80107ff7:	74 d0                	je     80107fc9 <clearpteu+0x19>
  *pte &= ~PTE_U;
80107ff9:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80107ffc:	c9                   	leave  
80107ffd:	c3                   	ret    
80107ffe:	66 90                	xchg   %ax,%ax

80108000 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80108000:	55                   	push   %ebp
80108001:	89 e5                	mov    %esp,%ebp
80108003:	57                   	push   %edi
80108004:	56                   	push   %esi
80108005:	53                   	push   %ebx
80108006:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80108009:	e8 02 ff ff ff       	call   80107f10 <setupkvm>
8010800e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80108011:	85 c0                	test   %eax,%eax
80108013:	0f 84 bd 00 00 00    	je     801080d6 <copyuvm+0xd6>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80108019:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010801c:	85 c9                	test   %ecx,%ecx
8010801e:	0f 84 b2 00 00 00    	je     801080d6 <copyuvm+0xd6>
80108024:	31 f6                	xor    %esi,%esi
80108026:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010802d:	8d 76 00             	lea    0x0(%esi),%esi
  if(*pde & PTE_P){
80108030:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pde = &pgdir[PDX(va)];
80108033:	89 f0                	mov    %esi,%eax
80108035:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80108038:	8b 04 81             	mov    (%ecx,%eax,4),%eax
8010803b:	a8 01                	test   $0x1,%al
8010803d:	75 11                	jne    80108050 <copyuvm+0x50>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
8010803f:	83 ec 0c             	sub    $0xc,%esp
80108042:	68 e0 8d 10 80       	push   $0x80108de0
80108047:	e8 34 83 ff ff       	call   80100380 <panic>
8010804c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
80108050:	89 f2                	mov    %esi,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80108052:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80108057:	c1 ea 0a             	shr    $0xa,%edx
8010805a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80108060:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80108067:	85 c0                	test   %eax,%eax
80108069:	74 d4                	je     8010803f <copyuvm+0x3f>
    if(!(*pte & PTE_P))
8010806b:	8b 00                	mov    (%eax),%eax
8010806d:	a8 01                	test   $0x1,%al
8010806f:	0f 84 9f 00 00 00    	je     80108114 <copyuvm+0x114>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80108075:	89 c7                	mov    %eax,%edi
    flags = PTE_FLAGS(*pte);
80108077:	25 ff 0f 00 00       	and    $0xfff,%eax
8010807c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
8010807f:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
80108085:	e8 26 b2 ff ff       	call   801032b0 <kalloc>
8010808a:	89 c3                	mov    %eax,%ebx
8010808c:	85 c0                	test   %eax,%eax
8010808e:	74 64                	je     801080f4 <copyuvm+0xf4>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80108090:	83 ec 04             	sub    $0x4,%esp
80108093:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80108099:	68 00 10 00 00       	push   $0x1000
8010809e:	57                   	push   %edi
8010809f:	50                   	push   %eax
801080a0:	e8 ab d5 ff ff       	call   80105650 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
801080a5:	58                   	pop    %eax
801080a6:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801080ac:	5a                   	pop    %edx
801080ad:	ff 75 e4             	push   -0x1c(%ebp)
801080b0:	b9 00 10 00 00       	mov    $0x1000,%ecx
801080b5:	89 f2                	mov    %esi,%edx
801080b7:	50                   	push   %eax
801080b8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801080bb:	e8 60 f8 ff ff       	call   80107920 <mappages>
801080c0:	83 c4 10             	add    $0x10,%esp
801080c3:	85 c0                	test   %eax,%eax
801080c5:	78 21                	js     801080e8 <copyuvm+0xe8>
  for(i = 0; i < sz; i += PGSIZE){
801080c7:	81 c6 00 10 00 00    	add    $0x1000,%esi
801080cd:	39 75 0c             	cmp    %esi,0xc(%ebp)
801080d0:	0f 87 5a ff ff ff    	ja     80108030 <copyuvm+0x30>
  return d;

bad:
  freevm(d);
  return 0;
}
801080d6:	8b 45 e0             	mov    -0x20(%ebp),%eax
801080d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801080dc:	5b                   	pop    %ebx
801080dd:	5e                   	pop    %esi
801080de:	5f                   	pop    %edi
801080df:	5d                   	pop    %ebp
801080e0:	c3                   	ret    
801080e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
801080e8:	83 ec 0c             	sub    $0xc,%esp
801080eb:	53                   	push   %ebx
801080ec:	e8 ff af ff ff       	call   801030f0 <kfree>
      goto bad;
801080f1:	83 c4 10             	add    $0x10,%esp
  freevm(d);
801080f4:	83 ec 0c             	sub    $0xc,%esp
801080f7:	ff 75 e0             	push   -0x20(%ebp)
801080fa:	e8 91 fd ff ff       	call   80107e90 <freevm>
  return 0;
801080ff:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80108106:	83 c4 10             	add    $0x10,%esp
}
80108109:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010810c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010810f:	5b                   	pop    %ebx
80108110:	5e                   	pop    %esi
80108111:	5f                   	pop    %edi
80108112:	5d                   	pop    %ebp
80108113:	c3                   	ret    
      panic("copyuvm: page not present");
80108114:	83 ec 0c             	sub    $0xc,%esp
80108117:	68 fa 8d 10 80       	push   $0x80108dfa
8010811c:	e8 5f 82 ff ff       	call   80100380 <panic>
80108121:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108128:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010812f:	90                   	nop

80108130 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80108130:	55                   	push   %ebp
80108131:	89 e5                	mov    %esp,%ebp
80108133:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80108136:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80108139:	89 c1                	mov    %eax,%ecx
8010813b:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
8010813e:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80108141:	f6 c2 01             	test   $0x1,%dl
80108144:	0f 84 00 01 00 00    	je     8010824a <uva2ka.cold>
  return &pgtab[PTX(va)];
8010814a:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010814d:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80108153:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
80108154:	25 ff 03 00 00       	and    $0x3ff,%eax
  if((*pte & PTE_P) == 0)
80108159:	8b 84 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%eax
  if((*pte & PTE_U) == 0)
80108160:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80108162:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80108167:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
8010816a:	05 00 00 00 80       	add    $0x80000000,%eax
8010816f:	83 fa 05             	cmp    $0x5,%edx
80108172:	ba 00 00 00 00       	mov    $0x0,%edx
80108177:	0f 45 c2             	cmovne %edx,%eax
}
8010817a:	c3                   	ret    
8010817b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010817f:	90                   	nop

80108180 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80108180:	55                   	push   %ebp
80108181:	89 e5                	mov    %esp,%ebp
80108183:	57                   	push   %edi
80108184:	56                   	push   %esi
80108185:	53                   	push   %ebx
80108186:	83 ec 0c             	sub    $0xc,%esp
80108189:	8b 75 14             	mov    0x14(%ebp),%esi
8010818c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010818f:	8b 55 10             	mov    0x10(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80108192:	85 f6                	test   %esi,%esi
80108194:	75 51                	jne    801081e7 <copyout+0x67>
80108196:	e9 a5 00 00 00       	jmp    80108240 <copyout+0xc0>
8010819b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010819f:	90                   	nop
  return (char*)P2V(PTE_ADDR(*pte));
801081a0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801081a6:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
801081ac:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
801081b2:	74 75                	je     80108229 <copyout+0xa9>
      return -1;
    n = PGSIZE - (va - va0);
801081b4:	89 fb                	mov    %edi,%ebx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801081b6:	89 55 10             	mov    %edx,0x10(%ebp)
    n = PGSIZE - (va - va0);
801081b9:	29 c3                	sub    %eax,%ebx
801081bb:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801081c1:	39 f3                	cmp    %esi,%ebx
801081c3:	0f 47 de             	cmova  %esi,%ebx
    memmove(pa0 + (va - va0), buf, n);
801081c6:	29 f8                	sub    %edi,%eax
801081c8:	83 ec 04             	sub    $0x4,%esp
801081cb:	01 c1                	add    %eax,%ecx
801081cd:	53                   	push   %ebx
801081ce:	52                   	push   %edx
801081cf:	51                   	push   %ecx
801081d0:	e8 7b d4 ff ff       	call   80105650 <memmove>
    len -= n;
    buf += n;
801081d5:	8b 55 10             	mov    0x10(%ebp),%edx
    va = va0 + PGSIZE;
801081d8:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
  while(len > 0){
801081de:	83 c4 10             	add    $0x10,%esp
    buf += n;
801081e1:	01 da                	add    %ebx,%edx
  while(len > 0){
801081e3:	29 de                	sub    %ebx,%esi
801081e5:	74 59                	je     80108240 <copyout+0xc0>
  if(*pde & PTE_P){
801081e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
801081ea:	89 c1                	mov    %eax,%ecx
    va0 = (uint)PGROUNDDOWN(va);
801081ec:	89 c7                	mov    %eax,%edi
  pde = &pgdir[PDX(va)];
801081ee:	c1 e9 16             	shr    $0x16,%ecx
    va0 = (uint)PGROUNDDOWN(va);
801081f1:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if(*pde & PTE_P){
801081f7:	8b 0c 8b             	mov    (%ebx,%ecx,4),%ecx
801081fa:	f6 c1 01             	test   $0x1,%cl
801081fd:	0f 84 4e 00 00 00    	je     80108251 <copyout.cold>
  return &pgtab[PTX(va)];
80108203:	89 fb                	mov    %edi,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80108205:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
8010820b:	c1 eb 0c             	shr    $0xc,%ebx
8010820e:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
80108214:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
  if((*pte & PTE_U) == 0)
8010821b:	89 d9                	mov    %ebx,%ecx
8010821d:	83 e1 05             	and    $0x5,%ecx
80108220:	83 f9 05             	cmp    $0x5,%ecx
80108223:	0f 84 77 ff ff ff    	je     801081a0 <copyout+0x20>
  }
  return 0;
}
80108229:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010822c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80108231:	5b                   	pop    %ebx
80108232:	5e                   	pop    %esi
80108233:	5f                   	pop    %edi
80108234:	5d                   	pop    %ebp
80108235:	c3                   	ret    
80108236:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010823d:	8d 76 00             	lea    0x0(%esi),%esi
80108240:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80108243:	31 c0                	xor    %eax,%eax
}
80108245:	5b                   	pop    %ebx
80108246:	5e                   	pop    %esi
80108247:	5f                   	pop    %edi
80108248:	5d                   	pop    %ebp
80108249:	c3                   	ret    

8010824a <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
8010824a:	a1 00 00 00 00       	mov    0x0,%eax
8010824f:	0f 0b                	ud2    

80108251 <copyout.cold>:
80108251:	a1 00 00 00 00       	mov    0x0,%eax
80108256:	0f 0b                	ud2    
