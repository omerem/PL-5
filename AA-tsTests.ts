import * as A from "./q2";
import * as assert from "assert";


const t1: A.Tree = {value: 5};

const t2: A.Tree = {children: [
 {children: [{value:1}, {value:7}, {value:5}]},
{value:3},
{value:10}]};

const t3: A.Tree = {children: [
 {children: [{value:20}, {value:5}, {value:50}]},
 {value:5}]}; 

 const t4: A.Tree = {children: [
    {children: [{value:1}, {value:7}, {value:5}]},
   {value:3},
   {value:9}]}; 

const t5: A.Tree = {value: 16}; 

const t6: A.Tree = {children: [
    {children: [{value:1}, {value:26}, {value:5}]},
   {value:28},
   {value:9}]}; 

const t7: A.Tree = {children: [
    {children: [{value:1}, {value:26}, {value:5}]},
   {value:3},
   {value:9}]}; 

const t8: A.Tree = {children: [
    {children: [{value:1}, {value:9}, {value:18}]},
   {value:3},
   {value:9}]};


const t9: A.Tree = {children: [
    {children: [{value:1}, {value:10}, {value:18}]},
   {value:3},
   {value:9}]};

const t10: A.Tree = {children: [
    {children: [{value:1}, {value:3}, {value:5}]},
   {value:30},
   {value:9}]};

const t11: A.Tree = {children: [
    {children: [{value:1}, {value:3}, {value:5}]},
   {value:30},
   {value:40}]};

const t12: A.Tree = {children: [
    {children: [{value:1}, {value:3}, {value:5}]},
   {value:33},
   {value:40}]};

const t13: A.Tree = {children: [
    {children: [{value:1}, {value:3}, {value:5}]},
    {children: [{value:77}, {value:3}, {value:11}]},
    {children: [{value:11}, {value:5}, {value:9}]}]};

const t14: A.Tree = {children: [
        {children: [{value:1}, {value:3}, {value:5}]},
        {children: [{value:77}, {value:3}, {value:11}]},
        {children: [{value:11}, {value:5}, {value:30}]}]};

const t15: A.Tree = {children: [
    {children: [{value:1}, {value:3}, {value:5}]},
    {children: [{value:77}, {value:3}, {value:11}]},
    {children: [{value:40}, {value:5}, {value:30}]}]};

   assert.deepEqual(A.leftMostEven1(t1),-1);
   assert.deepEqual(A.leftMostEven1(t2),10);
   assert.deepEqual(A.leftMostEven1(t3),20);
   assert.deepEqual(A.leftMostEven1(t4),-1); 
   assert.deepEqual(A.leftMostEven1(t5),16);
   assert.deepEqual(A.leftMostEven1(t6),26);
   assert.deepEqual(A.leftMostEven1(t7),26);
   assert.deepEqual(A.leftMostEven1(t8),18);
   assert.deepEqual(A.leftMostEven1(t9),10);
   assert.deepEqual(A.leftMostEven1(t10),30);
   assert.deepEqual(A.leftMostEven1(t11),30);
   assert.deepEqual(A.leftMostEven1(t12),40);
   assert.deepEqual(A.leftMostEven1(t13),-1);
   assert.deepEqual(A.leftMostEven1(t14),30);
   assert.deepEqual(A.leftMostEven1(t15),40);


   assert.deepEqual(A.leftMostEven2(t1),-1);
   assert.deepEqual(A.leftMostEven2(t2),10);
   assert.deepEqual(A.leftMostEven2(t3),20);
   assert.deepEqual(A.leftMostEven2(t4),-1); 
   assert.deepEqual(A.leftMostEven2(t5),16);
   assert.deepEqual(A.leftMostEven2(t6),26);
   assert.deepEqual(A.leftMostEven2(t7),26);
   assert.deepEqual(A.leftMostEven2(t8),18);
   assert.deepEqual(A.leftMostEven2(t9),10);
   assert.deepEqual(A.leftMostEven2(t10),30);
   assert.deepEqual(A.leftMostEven2(t11),30);
   assert.deepEqual(A.leftMostEven2(t12),40);
   assert.deepEqual(A.leftMostEven2(t13),-1);
   assert.deepEqual(A.leftMostEven2(t14),30);
   assert.deepEqual(A.leftMostEven2(t15),40);